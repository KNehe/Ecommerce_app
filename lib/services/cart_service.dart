import 'dart:convert';

import 'package:ecommerceapp/application.properties/app_properties.dart';
import 'package:http/http.dart' as http;

class CartService {
  static CartService _cartService;

  CartService._internal() {
    _cartService = this;
  }

  factory CartService() => _cartService ?? CartService._internal();

  static var httpClient = http.Client();

  static Map<String, String> headers = {'Content-Type': 'application/json'};

  Future saveCart(
    String productId,
    String userId,
    String quantity,
    String jwtToken,
  ) async {
    var bodyObject = Map<String, String>();
    bodyObject.putIfAbsent('productId', () => productId);
    bodyObject.putIfAbsent('userId', () => userId);
    bodyObject.putIfAbsent('quantity', () => quantity);

    headers.putIfAbsent('Authorization', () => 'Bearer $jwtToken');

    return await http.post(
      AppProperties.cartUrl,
      body: json.encode(bodyObject),
      headers: headers,
    );
  }

  Future getCart(
    String userId,
    String jwtToken,
  ) async {
    headers.putIfAbsent('Authorization', () => 'Bearer $jwtToken');
    return await http.get(
      '${AppProperties.cartUrl}/$userId',
      headers: headers,
    );
  }
}
