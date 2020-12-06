import 'package:ecommerceapp/application.properties/app_properties.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static ProductService _productService;

  ProductService._internal() {
    _productService = this;
  }

  factory ProductService() => _productService ?? ProductService._internal();

  static var httpClient = http.Client();

  Future getAllProducts() async {
    return await http.get(AppProperties.productUrl);
  }

  Future getProductByCategoryOrName(String value) async {
    return await http.get('${AppProperties.searchByCategoryOrNameUrl}$value');
  }

  Future getProductByCategory(String value) async {
    return await http.get('${AppProperties.searchByCategoryUrl}$value');
  }

  Future getProductById(String id) async {
    return await http.get('${AppProperties.productUrl}$id');
  }
}
