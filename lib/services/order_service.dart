import 'package:ecommerceapp/application.properties/app_properties.dart';
import 'package:http/http.dart' as http;

class OrderService {
  static OrderService _orderService;

  OrderService._internal() {
    _orderService = this;
  }

  factory OrderService() => _orderService ?? OrderService._internal();

  static var httpClient = http.Client();

  Future getShippingCost(String country) async {
    //can used to fetch shipping cost for a particular place from API.
    return 0;
  }

  Future getTax(String country) async {
    //can used to fetch tax for a particular place from API.
    return 100;
  }

  Future saveOrder(String order) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    return await httpClient.post(AppProperties.saveOrderUrl,
        body: order, headers: headers);
  }

  Future sendPayPalRequest(String order, String nonce) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    return await httpClient.post('${AppProperties.payPalRequestUrl}$nonce',
        body: order, headers: headers);
  }
}
