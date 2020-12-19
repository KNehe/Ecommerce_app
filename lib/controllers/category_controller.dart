import 'dart:io';

import 'package:ecommerceapp/controllers/error_controller.dart';
import 'package:ecommerceapp/models/category.dart';
import 'package:ecommerceapp/services/category_service.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoryController extends ChangeNotifier {
  final _categoryService = CategoryService();

  var _isLoadingCategories = true;

  var _categoryList = List<CategoryModel>();

  List<CategoryModel> get categoryList => _categoryList;

  bool get isLoadingCategories => _isLoadingCategories;

  setIsLoadingCategories(bool value) {
    _isLoadingCategories = value;
    notifyListeners();
  }

  void getAllCategories(GlobalKey<ScaffoldState> scaffoldKey) async {
    try {
      _isLoadingCategories = true;
      //important when refresh indicator is called
      //to avoid add same items
      _categoryList.clear();

      var response = await _categoryService.getCategories();

      if (response.statusCode == 200) {
        var jsonBody = json.decode(response.body);
        var jsonCategories = jsonBody['data']['categories'];
        _categoryList.addAll(categoryFromJson(json.encode(jsonCategories)));
        _isLoadingCategories = false;
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
}
