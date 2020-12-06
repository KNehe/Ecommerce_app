import 'dart:io';

import 'package:ecommerceapp/controllers/error_controller.dart';
import 'package:ecommerceapp/models/product.dart';
import 'package:ecommerceapp/services/product_service.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProductController extends ChangeNotifier {
  final _productService = ProductService();

  var productList = List<Product>();

  var isLoadingAllProducts = true;

  var isLoadingProduct = true;

  void getAllProducts(GlobalKey<ScaffoldState> scaffoldKey) async {
    try {
      isLoadingAllProducts = true;

      //important when refresh indicator is called
      //to avoid add same items
      productList.clear();

      var response = await _productService.getAllProducts();

      if (response.statusCode == 200) {
        var responseJsonStr = json.decode(response.body);
        var jsonProd = responseJsonStr['data']['products'];
        productList.addAll(productFromJson(json.encode(jsonProd)));
        isLoadingAllProducts = false;
        notifyListeners();
      } else {
        ErrorController.showErrorFromApi(scaffoldKey, response);
      }
    } on SocketException catch (_) {
      ErrorController.showNoInternetError(scaffoldKey);
    } on HttpException catch (_) {
      ErrorController.showNoServerError(scaffoldKey);
    } on FormatException catch (_) {
      ErrorController.showFormatExceptionError(scaffoldKey);
    } catch (e) {
      print("Error ${e.toString()}");
      ErrorController.showUnKownError(scaffoldKey);
    }
  }

  void getProductByCategory(
      String value, GlobalKey<ScaffoldState> scaffoldKey) async {
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
        ErrorController.showErrorFromApi(scaffoldKey, response);
      }
    } on SocketException catch (_) {
      ErrorController.showNoInternetError(scaffoldKey);
    } on HttpException catch (_) {
      ErrorController.showNoServerError(scaffoldKey);
    } on FormatException catch (_) {
      ErrorController.showFormatExceptionError(scaffoldKey);
    } catch (e) {
      print("Error ${e.toString()}");
      ErrorController.showUnKownError(scaffoldKey);
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
        isLoadingAllProducts = true;
        notifyListeners();
      }
    } on SocketException catch (_) {
      isLoadingAllProducts = true;
      notifyListeners();
    } on HttpException catch (_) {
      isLoadingAllProducts = true;
      notifyListeners();
    } catch (e) {
      print("Error ${e.toString()}");
      isLoadingAllProducts = true;
      notifyListeners();
    }
  }
}
