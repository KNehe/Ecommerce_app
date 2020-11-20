import 'package:ecommerceapp/models/category.dart';
import 'package:ecommerceapp/services/category_service.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CategoryController extends ChangeNotifier {
  final _categoryService = CategoryService();

  var isLoadingCategories = true;

  var categoryList = List<CategoryModel>();

  void getAllCategories() async {
    try {
      isLoadingCategories = true;

      var response = await _categoryService.getCategories();

      if (response.statusCode == 200) {
        var jsonBody = json.decode(response.body);
        var jsonCategories = jsonBody['data']['categories'];
        categoryList.addAll(categoryFromJson(json.encode(jsonCategories)));
        isLoadingCategories = false;
        notifyListeners();
      } else {
        print("fail ${response.body}");
        isLoadingCategories = false;
        notifyListeners();
      }
    } catch (e) {
      print("Category load error: ${e.toString()}");
      isLoadingCategories = false;
      notifyListeners();
    }
  }
}
