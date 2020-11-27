import 'package:ecommerceapp/constants/screen_ids.dart';
import 'package:ecommerceapp/constants/tasks.dart';
import 'package:ecommerceapp/controllers/activity_tracker_controller.dart';
import 'package:ecommerceapp/controllers/order_controller.dart';
import 'package:ecommerceapp/controllers/shipping_controller.dart';
import 'package:ecommerceapp/models/shipping_details.dart';
import 'package:ecommerceapp/screens/payment_method.dart';
import 'package:ecommerceapp/screens/shopping_cart.dart';
import 'package:ecommerceapp/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Shipping extends StatefulWidget {
  Shipping({Key key}) : super(key: key);
  static String id = Shipping_Screen_Id;

  @override
  _ShippingState createState() => _ShippingState();
}

class _ShippingState extends State<Shipping> {
  var _shippingDdetailsFormkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  //this is to avoid showing bottom sheet again on previous shopping cart screen
  Future<bool> _onBackPressed() {
    Navigator.popUntil(context, ModalRoute.withName(ShoppingCart.id));
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    String _name;
    String _phoneContact;
    String _addressLine;
    String _city;
    String _postalCode;
    String _country;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Shipping details',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: Container(
            margin: EdgeInsets.all(18),
            child: ListView(
              children: [
                Form(
                  key: _shippingDdetailsFormkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: "Enter name *",
                          icon: Icon(
                            Icons.person,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        onSaved: (value) => _name = value,
                        validator: (value) => value.isEmpty ? 'Required' : null,
                        initialValue:
                            '${context.watch<ShippingController>().shippingDetails.name}',
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Enter phone number *",
                          icon: Icon(
                            Icons.phone,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        onSaved: (value) => _phoneContact = value,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Required';
                          }
                          if (!Validator.isPhoneNumberValid(value)) {
                            return "Invalid phone number";
                          }
                          return null;
                        },
                        initialValue:
                            '${context.watch<ShippingController>().shippingDetails.phoneContact}',
                      ),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: "Enter address line*",
                          icon: Icon(
                            Icons.place,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        onSaved: (value) => _addressLine = value,
                        validator: (value) => value.isEmpty ? 'Required' : null,
                        initialValue:
                            '${context.watch<ShippingController>().shippingDetails.addressLine}',
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Enter City *",
                          icon: Icon(
                            Icons.location_city,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        onSaved: (value) => _city = value,
                        validator: (value) => value.isEmpty ? 'Required' : null,
                        initialValue:
                            '${context.watch<ShippingController>().shippingDetails.city}',
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Enter Postal Code *",
                          icon: Icon(
                            Icons.local_post_office,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        onSaved: (value) => _postalCode = value,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Required';
                          }
                          if (!Validator.isPostalCodeValid(value)) {
                            return 'Invalid postal code';
                          }
                          return null;
                        },
                        initialValue:
                            '${context.watch<ShippingController>().shippingDetails.postalCode}',
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Enter Country *",
                          icon: Icon(
                            Icons.my_location,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        onSaved: (value) => _country = value,
                        validator: (value) => value.isEmpty ? 'Required' : null,
                        initialValue:
                            '${context.watch<ShippingController>().shippingDetails.country}',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        onPressed: () {
                          if (_shippingDdetailsFormkey.currentState
                              .validate()) {
                            _shippingDdetailsFormkey.currentState.save();

                            var shippingDetails = ShippingDetails(
                              name: _name,
                              phoneContact: _phoneContact,
                              city: _city,
                              addressLine: _addressLine,
                              postalCode: _postalCode,
                              country: _country,
                            );

                            Provider.of<ActivityTracker>(context, listen: false)
                                .setTaskCurrentTask(
                                    VIEWING_SINGLE_NEW_ORDER_HISTORY);

                            Provider.of<ShippingController>(context,
                                    listen: false)
                                .setShippingDetails(details: shippingDetails);

                            Provider.of<OrderController>(context, listen: false)
                                .setShippingCost(_country);

                            Provider.of<OrderController>(context, listen: false)
                                .setTax(_country);

                            Navigator.pushNamed(context, PaymentMethod.id);
                          }
                        },
                        child: Text(
                          "CONTINUE",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
