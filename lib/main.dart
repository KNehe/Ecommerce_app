import 'package:ecommerceapp/controllers/activity_tracker_controller.dart';
import 'package:ecommerceapp/controllers/cart_controller.dart';
import 'package:ecommerceapp/controllers/category_controller.dart';
import 'package:ecommerceapp/controllers/order_controller.dart';
import 'package:ecommerceapp/controllers/product_controller.dart';
import 'package:ecommerceapp/controllers/shipping_controller.dart';
import 'package:ecommerceapp/screens/auth_screen.dart';
import 'package:ecommerceapp/screens/order_history.dart';
import 'package:ecommerceapp/screens/payment_method.dart';
import 'package:ecommerceapp/screens/product_detail.dart';
import 'package:ecommerceapp/screens/products_list.dart';
import 'package:ecommerceapp/screens/shipping.dart';
import 'package:ecommerceapp/screens/shopping_cart.dart';
import 'package:ecommerceapp/screens/single_order.dart';
import 'package:ecommerceapp/screens/thank_you.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductController()),
        ChangeNotifierProvider(create: (context) => CategoryController()),
        ChangeNotifierProvider(create: (context) => CartController()),
        ChangeNotifierProvider(create: (context) => ShippingController()),
        ChangeNotifierProvider(create: (context) => OrderController()),
        ChangeNotifierProvider(create: (context) => ActivityTracker()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ecommerce app',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: ProductList.id,
        routes: {
          ProductList.id: (context) => ProductList(),
          ShoppingCart.id: (context) => ShoppingCart(),
          ProductDetail.id: (context) => ProductDetail(),
          Shipping.id: (context) => Shipping(),
          PaymentMethod.id: (context) => PaymentMethod(),
          Thanks.id: (context) => Thanks(),
          SingleOrder.id: (context) => SingleOrder(),
          AuthScreen.id: (context) => AuthScreen(),
          OrderHistroy.id: (context) => OrderHistroy(),
        },
      ),
    );
  }
}
