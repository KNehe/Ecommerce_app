import 'package:ecommerceapp/constants/screen_ids.dart';
import 'package:ecommerceapp/constants/screen_titles.dart';
import 'package:ecommerceapp/controllers/auth_controller.dart';
import 'package:ecommerceapp/controllers/order_controller.dart';
import 'package:ecommerceapp/widgets/guest_user_order_history_widget.dart';
import 'package:ecommerceapp/widgets/no_order_history_content.dart';
import 'package:ecommerceapp/widgets/order_history_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderHistroy extends StatefulWidget {
  OrderHistroy({Key key}) : super(key: key);
  static String id = OrderHistoryScreen_Id;

  @override
  _OrderHistroyState createState() => _OrderHistroyState();
}

class _OrderHistroyState extends State<OrderHistroy> {
  var _authController;
  var _orderController;

  @override
  void initState() {
    _authController = AuthController();
    _orderController = Provider.of<OrderController>(context, listen: false);
    _orderController.getOrders();

    super.initState();
  }

  Future<bool> getTokenValidity() async {
    return await _authController.isTokenValid();
  }

  Future<List<String>> getLoginStatus() async {
    return await _authController.getUserIdAndLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    _orderController.getOrders();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "$OrderHistoryScreen_Title",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            FutureBuilder(
              future: Future.wait([getTokenValidity(), getLoginStatus()]),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 3),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                var isLoggedInFlag = snapshot.data[1][1];
                var isTokenValid = snapshot.data[0];

                //when user is not signed in
                if (isLoggedInFlag == null || isLoggedInFlag == '0') {
                  return GuestUserOrderHistoryWidget(
                    message: 'Sign in to see order history',
                  );
                }

                //when user token has expired
                if (!isTokenValid) {
                  return GuestUserOrderHistoryWidget(
                    message: 'Session expired. Sign in to see order history',
                  );
                }

                //user is logged in and token is valid
                return Consumer<OrderController>(
                    builder: (context, orderController, child) {
                  if (orderController.isLoadingOrders) {
                    return Center(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return Column(children: [
                    ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: orderController.orders.length,
                        itemBuilder: (context, index) {
                          if (orderController.orders.length == 0) {
                            return Center(
                              child: Container(
                                margin: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).size.height / 3),
                                child: NoOrderHistoryFoundContent(),
                              ),
                            );
                          }
                          return OrderHistoryItem(
                            order: orderController.orders[index],
                          );
                        })
                  ]);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
