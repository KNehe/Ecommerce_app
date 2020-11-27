import 'package:ecommerceapp/application.properties/app_properties.dart';
import 'package:http/http.dart' as http;

class OrderService {
  static OrderService _orderService;

  OrderService._internal() {
    _orderService = this;
  }

  factory OrderService() => _orderService ?? OrderService._internal();

  Map<String, String> headers = {'Content-Type': 'application/json'};

  static var httpClient = http.Client();

  Future getShippingCost(String country) async {
    //can be used to fetch shipping cost for a particular place from API.
    return 0;
  }

  Future getTax(String country) async {
    //can be used to fetch tax for a particular place from API.
    return 100;
  }

  //used to save order details after making stripe payment
  Future saveOrder(String order) async {
    return await httpClient.post(AppProperties.saveOrderUrl,
        body: order, headers: headers);
  }

  //used to send order details along with paypal nonce to process payment and save the order
  Future sendPayPalRequest(String order, String nonce) async {
    return await httpClient.post('${AppProperties.payPalRequestUrl}$nonce',
        body: order, headers: headers);
  }

  Future getOrders(String userId, String jwtToken) async {
    headers.putIfAbsent('Authorization', () => 'Bearer $jwtToken');
    return await httpClient.get('${AppProperties.getOrdersUrl}$userId',
        headers: headers);
  }
}
