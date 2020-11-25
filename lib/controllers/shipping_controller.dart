import 'package:ecommerceapp/models/shipping_details.dart';
import 'package:flutter/foundation.dart';

class ShippingController extends ChangeNotifier {
  var shippingDetails = ShippingDetails(
    name: '',
    phoneContact: '',
    city: '',
    addressLine: '',
    postalCode: '',
    country: '',
  );

  void setShippingDetails({@required ShippingDetails details}) {
    shippingDetails = details;
    notifyListeners();
  }

  ShippingDetails getShippingDetails() => shippingDetails;

  void reset() {
    shippingDetails = ShippingDetails(
      name: '',
      phoneContact: '',
      city: '',
      addressLine: '',
      postalCode: '',
      country: '',
    );
  }
}
