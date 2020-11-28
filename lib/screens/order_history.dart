import 'package:ecommerceapp/constants/screen_ids.dart';
import 'package:ecommerceapp/constants/screen_titles.dart';
import 'package:ecommerceapp/constants/tasks.dart';
import 'package:ecommerceapp/controllers/auth_controller.dart';
import 'package:ecommerceapp/controllers/order_controller.dart';
import 'package:ecommerceapp/widgets/guest_user_drawer_widget.dart';
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
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _authController = AuthController();
    _orderController = Provider.of<OrderController>(context, listen: false);
    _orderController.getOrders(_scaffoldKey);

    super.initState();
  }

  Future<bool> getTokenValidity() async {
    return await _authController.isTokenValid();
  }

  Future<List<String>> getLoginStatus() async {
    return await _authController.getUserDataAndLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                  return GuestUserDrawerWidget(
                    message: 'Sign in to see order history',
                    currentTask: VIEWING_ORDER_HISTORY,
                  );
                }

                //when user token has expired
                if (!isTokenValid) {
                  return GuestUserDrawerWidget(
                    message: 'Session expired. Sign in to see order history',
                    currentTask: VIEWING_ORDER_HISTORY,
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
                  if (orderController.orders.length == 0) {
                    return Center(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3),
                        child: Text(
                          'No order made',
                          style: TextStyle(fontSize: 15),
                        ),
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
