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
    var currentTask =
        Provider.of<ActivityTracker>(context, listen: false).currentTask;
    if (currentTask == VIEWING_SINGLE_OLD_ORDER_HISTORY) {
      Navigator.pop(context);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, ProductList.id, (route) => false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                '$SingleOrder_Screen_Title ${context.watch<OrderController>().singleOrder.id ?? ''}',
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
                        'Date and time ordered:  ${context.watch<OrderController>().singleOrder.dateOrdered ?? ''}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Payment method:  ${context.watch<OrderController>().singleOrder.paymentMethod ?? ''} ',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Shipping cost: \$ ${context.watch<OrderController>().singleOrder.shippingCost ?? ''}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Tax: \$ ${context.watch<OrderController>().singleOrder.tax ?? ''}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Total item price: \$ ${context.watch<OrderController>().singleOrder.totalItemPrice ?? ''}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Total: \$  ${context.watch<OrderController>().singleOrder.total ?? ''}',
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
                        'Name: ${context.watch<OrderController>().singleOrder.shippingDetails.name ?? ''}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Phone Contact:  ${context.watch<OrderController>().singleOrder.shippingDetails.phoneContact ?? ''}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Address Line:  ${context.watch<OrderController>().singleOrder.shippingDetails.addressLine ?? ''}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'City: ${context.watch<OrderController>().singleOrder.shippingDetails.city ?? ''}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Postal code: ${context.watch<OrderController>().singleOrder.shippingDetails.postalCode ?? ''}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Country:  ${context.watch<OrderController>().singleOrder.shippingDetails.country ?? ''}',
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
                      Consumer<OrderController>(
                          builder: (context, ctlr, chidl) {
                        if (ctlr.isProcessingOrder &&
                            ctlr.singleOrder.cartItems == null) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: ctlr.singleOrder.cartItems.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name: ${ctlr.singleOrder.cartItems[index].product.name}",
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    "Price: ${ctlr.singleOrder.cartItems[index].product.price}",
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    "Quantity: ${ctlr.singleOrder.cartItems[index].quantity}",
                                  ),
                                  Divider(
                                    thickness: 5,
                                    color: Colors.grey,
                                  ),
                                ],
                              );
                            });
                      }),

                      SizedBox(height: 10.0),
                      Center(
                        child: RaisedButton(
                          elevation: 0,
                          onPressed: () {},
                          child: Text(
                            "${context.watch<ActivityTracker>().currentTask == VIEWING_SINGLE_OLD_ORDER_HISTORY ? 'Thank you for the support' : "WE'LL CONTACT YOU SHORTLY"}",
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
