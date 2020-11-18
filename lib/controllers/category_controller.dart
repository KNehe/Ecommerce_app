import 'package:ecommerceapp/models/category.dart';
import 'package:ecommerceapp/services/category_service.dart';
import 'package:get/get.dart';
import 'dart:convert';

class CategoryController extends GetxController {
  final _categoryService = CategoryService();

  var isLoadingCategories = true.obs;

  var categoryList = List<Category>().obs;
  @override
  void onInit() {
    getAllCategories();
    super.onInit();
  }

  void getAllCategories() async {
    try {
      isLoadingCategories(true);

      var response = await _categoryService.getCategories();

      if (response.statusCode == 200) {
        var jsonBody = json.decode(response.body);
        var jsonCategories = jsonBody['data']['categories'];
        categoryList.assignAll(categoryFromJson(json.encode(jsonCategories)));
        isLoadingCategories(false);
      } else {
        print("fail ${response.body}");
        isLoadingCategories(false);
      }
    } catch (e) {
      print("Category load error: ${e.toString()}");
      isLoadingCategories(false);
    }
  }
}
