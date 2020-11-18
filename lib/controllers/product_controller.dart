import 'package:ecommerceapp/models/product.dart';
import 'package:ecommerceapp/services/product_service.dart';
import 'package:get/get.dart';
import 'dart:convert';

class ProductController extends GetxController {
  final _productService = ProductService();

  var productList = List<Product>().obs;

  var isLoadingAllProducts = true.obs;

  var selectedProduct = Product().obs;

  @override
  void onInit() {
    getAllProducts();
    super.onInit();
  }

  void getAllProducts() async {
    try {
      isLoadingAllProducts(true);
      var response = await _productService.getAllProducts();

      if (response.statusCode == 200) {
        var responseJsonStr = json.decode(response.body);
        var jsonProd = responseJsonStr['data']['products'];
        productList.assignAll(productFromJson(json.encode(jsonProd)));
        isLoadingAllProducts(false);
      } else {
        print('failure');
        isLoadingAllProducts(false);
      }
    } catch (e) {
      isLoadingAllProducts(false);
      print("Error ${e.toString()}");
    }
  }

  void getProductByCategory(String value) async {
    try {
      isLoadingAllProducts(true);

      var response = value == 'All'
          ? await _productService.getAllProducts()
          : await _productService.getProductByCategory(value);

      if (response.statusCode == 200) {
        var responseJsonStr = json.decode(response.body);
        var jsonProd = value == 'All'
            ? responseJsonStr['data']['products']
            : responseJsonStr['data']['result'];

        productList.assignAll(productFromJson(json.encode(jsonProd)));
        isLoadingAllProducts(false);
      } else {
        print('failure');
        isLoadingAllProducts(false);
      }
    } catch (e) {
      isLoadingAllProducts(false);
      print("Error ${e.toString()}");
    }
  }

  void getProductByCategoryOrName(String value) async {
    var finalSearchValue = value.trim();
    try {
      isLoadingAllProducts(true);

      var response = finalSearchValue == ''
          ? await _productService.getAllProducts()
          : await _productService.getProductByCategoryOrName(finalSearchValue);

      if (response.statusCode == 200) {
        var responseJsonStr = json.decode(response.body);
        var jsonProd = finalSearchValue == ''
            ? responseJsonStr['data']['products']
            : responseJsonStr['data']['result'];

        productList.assignAll(productFromJson(json.encode(jsonProd)));
        isLoadingAllProducts(false);
      } else {
        print('failure');
        isLoadingAllProducts(false);
      }
    } catch (e) {
      isLoadingAllProducts(false);
      print("Error ${e.toString()}");
    }
  }
}
