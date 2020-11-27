import 'dart:convert';

import 'package:ecommerceapp/controllers/auth_controller.dart';
import 'package:ecommerceapp/models/cart_item.dart';
import 'package:ecommerceapp/models/product.dart';
import 'package:ecommerceapp/services/cart_service.dart';
import 'package:ecommerceapp/services/product_service.dart';
import 'package:flutter/foundation.dart';

class CartController extends ChangeNotifier {
  var cart = List<CartItem>();

  final _productService = ProductService();

  bool isLoadingProduct = true;

  CartItem selectedItem = CartItem();

  var _authController = AuthController();

  var _cartService = CartService();

  void setCurrentItem(String productId) async {
    try {
      isLoadingProduct = true;
      var response = await _productService.getProductById(productId);

      if (response.statusCode == 200) {
        var responseJsonStr = json.decode(response.body);
        var jsonProd = responseJsonStr['data']['product'];
        var product = Product.fromJson(jsonProd);
        var item = CartItem(product: product, quantity: 1);
        if (isItemInCart(item)) {
          var foundItem = getCartItem(item);
          selectedItem = foundItem;
          isLoadingProduct = false;
          notifyListeners();
        } else {
          selectedItem = CartItem(product: product, quantity: 1);
          isLoadingProduct = false;
          notifyListeners();
        }
      } else {
        print('failure');
        //to keep shimmer effect in ui
        isLoadingProduct = true;
        notifyListeners();
      }
    } catch (e) {
      //to keep shimmer effect in ui
      isLoadingProduct = true;
      print("Error ${e.toString()}");
      notifyListeners();
    }
  }

  void addToCart(CartItem cartItem) {
    cart.add(cartItem);
    notifyListeners();
  }

  bool isItemInCart(CartItem cartItem) {
    bool isFound = false;
    if (cart.length != 0) {
      for (CartItem item in cart) {
        if (item.product.id == cartItem.product.id) {
          isFound = true;
        }
      }
      return isFound;
    }
    return isFound;
  }

  void removeFromCart(CartItem cartItem) {
    var foundItem;
    if (cart.length != 0) {
      for (CartItem item in cart) {
        if (item.product.id == cartItem.product.id) {
          foundItem = item;
        }
      }
      cart.remove(foundItem);
      notifyListeners();
    }
  }

  increaseCartItemAndProductDetailItemQuantity() {
    if (isItemInCart(selectedItem)) {
      var foundItem = getCartItem(selectedItem);
      if (foundItem != null) {
        //this affects both selected item and item in cart's quantity
        foundItem.quantity++;
        notifyListeners();
      }
    } else {
      selectedItem.quantity++;
      notifyListeners();
    }
  }

  decreaseCartItemAndProductDetailItemQuantity() {
    if (isItemInCart(selectedItem)) {
      var foundItem = getCartItem(selectedItem);
      if (foundItem != null && foundItem.quantity > 1) {
        //this affects both selected item and item in cart's quantity
        foundItem.quantity--;
        notifyListeners();
      }
    } else {
      if (selectedItem.quantity > 1) {
        selectedItem.quantity--;
        notifyListeners();
        printCart();
      }
    }
  }

  CartItem getCartItem(CartItem cartItem) {
    var foundItem;
    for (CartItem item in cart) {
      if (item.product.id == cartItem.product.id) {
        foundItem = item;
      }
    }
    return foundItem;
  }

  singleCartItemIncrease(CartItem cartItem) {
    var foundItem = getCartItem(cartItem);
    if (foundItem != null) {
      //this affects both selected item and item in cart's quantity
      foundItem.quantity++;
      notifyListeners();
    }
  }

  singleCartItemDecrease(CartItem cartItem) {
    var foundItem = getCartItem(cartItem);
    if (foundItem != null && foundItem.quantity > 1) {
      //this affects both selected item and item in cart's quantity
      foundItem.quantity--;
      notifyListeners();
    }
  }

  printCart() {
    for (CartItem item in cart) {
      print(
          "name: ${item.product.name}, qty ${item.quantity}, 'sel; ${selectedItem.quantity}");
    }
    print("__________________________________________________");
  }

  resetCart() {
    cart.clear();
    deleteSavedCart();
  }

  saveCart(List<CartItem> cart) async {
    cart.forEach((cartItem) async {
      var productId = cartItem.product.id;
      var quantity = cartItem.quantity.toString();
      var authData = await _authController.getUserDataAndLoginStatus();
      await _cartService.saveCart(
          productId, authData[0], quantity, authData[2]);
    });
  }

  //get cart from db if it was saved at check out stage
  //can only be saved if user logged in
  //can only be loaded if jwt token didn't expire
  getSavedCart() async {
    try {
      var authData = await _authController.getUserDataAndLoginStatus();
      var userId = authData[0];
      var jwtToken = authData[2];

      var response = await _cartService.getCart(userId, jwtToken);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var cartObj = jsonResponse['data']['cart'];
        cart.addAll(cartItemFromJson(json.encode(cartObj)));

        notifyListeners();
      } else {
        //cart isn't updated because it wasn't saved,or jwt expired
        //that is okay. User can proceed with using the app
        //will be prompted to either login or continue as guest at checkout stage
        //else block included for future implementation when required
      }
    } catch (e) {
      print('Get saved cart err ${e.toString()}');
    }
  }

  deleteSavedCart() async {
    try {
      var authData = await _authController.getUserDataAndLoginStatus();
      var userId = authData[0];

      var response = await _cartService.deleteCart(userId);

      if (response.statusCode == 204) {
        print('cart deleted');
      } else {
        print('cart not deleted');
      }
    } catch (e) {
      print('Delete saved cart err ${e.toString()}');
    }
  }
}
