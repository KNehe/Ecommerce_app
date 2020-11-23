import 'dart:convert';
import 'package:ecommerceapp/constants/payment.dart';
import 'package:ecommerceapp/models/cart_item.dart';
import 'package:ecommerceapp/models/order.dart';
import 'package:ecommerceapp/models/shipping_details.dart';
import 'package:ecommerceapp/services/order_service.dart';
import 'package:flutter/foundation.dart';

class OrderController extends ChangeNotifier {
  final _orderService = OrderService();
  var shippingCost;
  var tax;
  Order singleOrder;
  void setShippingCost(String country) async {
    try {
      shippingCost = await _orderService.getShippingCost(country);
    } catch (e) {
      print('Order controller ${e.toString()}');
    }
  }

  void setTax(String country) async {
    try {
      tax = await _orderService.getTax(country);
    } catch (e) {
      print('Order controller ${e.toString()}');
    }
  }

  void registerOrderWithStripePayment(
    ShippingDetails shippingDetails,
    String shippingCost,
    String tax,
    String total,
    String totalItemPrice,
    String userId,
    String paymentMethod,
    List<CartItem> cart,
  ) async {
    try {
      var userType = userId != null ? USER_TYPE_RESGISTERED : USER_TYPE_GUEST;
      var order = Order(
        shippingDetails: shippingDetails,
        shippingCost: shippingCost,
        tax: tax,
        total: total,
        totalItemPrice: totalItemPrice,
        userId: userId,
        paymentMethod: paymentMethod,
        userType: userType,
        dateOrdered: DateTime.now(),
        cartItems: cart,
      );
      var orderToJson = order.toJson();
      var response = await _orderService.saveOrder(json.encode(orderToJson));
      if (response.statusCode == 200) {
        var jsonD = json.decode(response.body);
        singleOrder = orderFromJson(json.encode(jsonD['data']));
      } else {
        print("error");
      }
    } catch (e) {
      print('Order controller Error: $e');
    }
  }
}
