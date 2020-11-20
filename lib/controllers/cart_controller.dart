import 'package:ecommerceapp/models/cart_item.dart';
import 'package:ecommerceapp/models/product.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cart = List<CartItem>().obs;

  var selectedItem = Product().obs;
  var selectedItemQty = 2.obs;

  void addToCart({CartItem cartItem}) {
    if (!isItemInCart(cartItem)) {
      return cart.add(cartItem);
    }
  }

  bool removeFromCart({CartItem cartItem}) {
    if (isItemInCart(cartItem)) {
      return cart.remove(cartItem);
    }
    return false;
  }

  bool isItemInCart(CartItem cartItem) {
    bool isFound = false;
    for (CartItem item in cart) {
      if (item.product.id == cartItem.product.id) {
        isFound = true;
      }
    }
    return isFound;
  }

  increaseQuanity({CartItem cartItem}) {
    for (CartItem item in cart) {
      if (item.product.id == cartItem.product.id) {
        item.quantity += 1;
        selectedItemQty.value = item.quantity;
      }
    }
  }

  printCart({CartItem cartItem}) {
    for (CartItem item in cart) {
      print(
          "name: ${item.product.name}, qty ${item.quantity}, 'sel; ${selectedItemQty.value}");
    }
    print("__________________________________________________");
  }
}
