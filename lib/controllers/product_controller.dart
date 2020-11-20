import 'package:ecommerceapp/models/product.dart';
import 'package:ecommerceapp/services/product_service.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProductController extends ChangeNotifier {
  final _productService = ProductService();

  var productList = List<Product>();

  var isLoadingAllProducts = true;

  var isLoadingProduct = true;

  var selectedProduct = Product();

  void getAllProducts() async {
    try {
      isLoadingAllProducts = true;
      var response = await _productService.getAllProducts();

      if (response.statusCode == 200) {
        var responseJsonStr = json.decode(response.body);
        var jsonProd = responseJsonStr['data']['products'];
        productList.addAll(productFromJson(json.encode(jsonProd)));
        isLoadingAllProducts = false;
        notifyListeners();
      } else {
        print('failure');
        isLoadingAllProducts = false;
        notifyListeners();
      }
    } catch (e) {
      isLoadingAllProducts = false;
      print("Error ${e.toString()}");
      notifyListeners();
    }
  }

  void getProductByCategory(String value) async {
    try {
      isLoadingAllProducts = true;

      var response = value == 'All'
          ? await _productService.getAllProducts()
          : await _productService.getProductByCategory(value);

      if (response.statusCode == 200) {
        var responseJsonStr = json.decode(response.body);
        var jsonProd = value == 'All'
            ? responseJsonStr['data']['products']
            : responseJsonStr['data']['result'];

        productList.clear();
        productList.addAll(productFromJson(json.encode(jsonProd)));
        isLoadingAllProducts = false;
        notifyListeners();
      } else {
        print('failure');
        isLoadingAllProducts = false;
        notifyListeners();
      }
    } catch (e) {
      isLoadingAllProducts = false;
      print("Error ${e.toString()}");
      notifyListeners();
    }
  }

  void getProductByCategoryOrName(String value) async {
    var finalSearchValue = value.trim();
    try {
      isLoadingAllProducts = true;

      var response = finalSearchValue == ''
          ? await _productService.getAllProducts()
          : await _productService.getProductByCategoryOrName(finalSearchValue);

      if (response.statusCode == 200) {
        var responseJsonStr = json.decode(response.body);
        var jsonProd = finalSearchValue == ''
            ? responseJsonStr['data']['products']
            : responseJsonStr['data']['result'];

        productList.clear();
        productList.addAll(productFromJson(json.encode(jsonProd)));
        isLoadingAllProducts = false;
        notifyListeners();
      } else {
        print('failure');
        isLoadingAllProducts = false;
        notifyListeners();
      }
    } catch (e) {
      isLoadingAllProducts = false;
      print("Error ${e.toString()}");
      notifyListeners();
    }
  }

  void getProductById(String id) async {
    try {
      isLoadingProduct = true;
      var response = await _productService.getProductById(id);

      if (response.statusCode == 200) {
        var responseJsonStr = json.decode(response.body);
        var jsonProd = responseJsonStr['data']['product'];
        selectedProduct = Product.fromJson(jsonProd);
        isLoadingProduct = false;
        notifyListeners();
      } else {
        print('failure');
        isLoadingProduct = false;
        notifyListeners();
      }
    } catch (e) {
      isLoadingProduct = false;
      print("Error ${e.toString()}");
      notifyListeners();
    }
  }
}
