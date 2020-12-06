import 'package:ecommerceapp/constants/screen_ids.dart';
import 'package:ecommerceapp/constants/screen_titles.dart';
import 'package:ecommerceapp/constants/tasks.dart';
import 'package:ecommerceapp/controllers/activity_tracker_controller.dart';
import 'package:ecommerceapp/controllers/order_controller.dart';
import 'package:ecommerceapp/screens/products_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleOrder extends StatefulWidget {
  SingleOrder({Key key}) : super(key: key);
  static String id = SingleOrder_Screen_Id;

  @override
  _SingleOrderState createState() => _SingleOrderState();
}

class _SingleOrderState extends State<SingleOrder> {
  Future<bool> _onBackPressed() {
    if (_currentTask == VIEWING_SINGLE_OLD_ORDER_HISTORY) {
      Navigator.pop(context);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, ProductList.id, (route) => false);
    }
    return Future.value(true);
  }

  var orderDetails;
  var _currentTask;

  @override
  void initState() {
    super.initState();
    orderDetails =
        Provider.of<OrderController>(context, listen: false).singleOrder;
    _currentTask =
        Provider.of<ActivityTracker>(context, listen: false).currentTask;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                '$SingleOrder_Screen_Title ${orderDetails.id}',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              iconTheme: IconThemeData(color: Colors.black),
              elevation: 1,
              backgroundColor: Colors.white,
            ),
            body: Container(
              margin: EdgeInsets.only(left: 20.0, right: 10.0),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //order details
                      SizedBox(height: 20.0),
                      Text(
                        'SHIPPING DETAILS',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'Date and time ordered: ${orderDetails.dateOrdered}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Payment method: ${orderDetails.paymentMethod}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Shipping cost: \$ ${orderDetails.shippingCost}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Tax: \$ ${orderDetails.tax}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Total item price: \$ ${orderDetails.totalItemPrice}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Total: \$ ${orderDetails.total}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),

                      //shipping details
                      SizedBox(height: 20.0),
                      Text(
                        'ORDER DETAILS',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'Name: ${orderDetails.shippingDetails.name}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Phone Contact: ${orderDetails.shippingDetails.phoneContact}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Address Line: ${orderDetails.shippingDetails.addressLine}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'City: ${orderDetails.shippingDetails.city}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Postal code: ${orderDetails.shippingDetails.postalCode}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Country: ${orderDetails.shippingDetails.country}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 20.0),

                      //items
                      Text(
                        'ITEMS',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: orderDetails.cartItems.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name: ${orderDetails.cartItems[index].product.name}",
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  "Price: ${orderDetails.cartItems[index].product.price}",
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  "Quantity: ${orderDetails.cartItems[index].quantity}",
                                ),
                                Divider(
                                  thickness: 5,
                                  color: Colors.grey,
                                ),
                              ],
                            );
                          }),

                      SizedBox(height: 10.0),
                      Center(
                        child: RaisedButton(
                          elevation: 0,
                          onPressed: () {},
                          child: Text(
                            "${_currentTask == VIEWING_SINGLE_OLD_ORDER_HISTORY ? 'Thank you for the support' : "WE'LL CONTACT YOU SHORTLY"}",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          color: Colors.orange[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
