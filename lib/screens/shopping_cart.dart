import 'package:badges/badges.dart';
import 'package:ecommerceapp/constants/screen_ids.dart';
import 'package:ecommerceapp/controllers/auth_controller.dart';
import 'package:ecommerceapp/controllers/cart_controller.dart';
import 'package:ecommerceapp/models/cart_item.dart';
import 'package:ecommerceapp/screens/products_list.dart';
import 'package:ecommerceapp/screens/shipping.dart';
import 'package:ecommerceapp/widgets/cart_button.dart';
import 'package:ecommerceapp/widgets/round_cart_button.dart';
import 'package:ecommerceapp/widgets/shopping_cart_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingCart extends StatefulWidget {
  ShoppingCart({Key key}) : super(key: key);

  static String id = ShoppingCart_Screen_Id;

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  double _rightMargin = 10;
  var _cartController;
  var _authController;

  @override
  void initState() {
    _cartController = Provider.of<CartController>(context, listen: false);
    _authController = AuthController();
    super.initState();
  }

  _handleItemQuantityIncrease(CartItem cartItem) {
    _cartController.singleCartItemIncrease(cartItem);
  }

  _handleItemQuantityDecrease(CartItem cartItem) {
    _cartController.singleCartItemDecrease(cartItem);
  }

  _handleRemoveCartItem(CartItem cartItem) {
    _cartController.removeFromCart(cartItem);
  }

  _checkoutButtonHandler(BuildContext context) async {
    var data = await _authController.getUserIdAndLoginStatus();
    //user is not logged in
    if (data[1] == null || data[1] == '0') {
      //provide option to continue as guest or log in
      Scaffold.of(context).showBottomSheet(
        (context) => ShoppingCartBottomSheet(),
      );
    } else {
      //check if jwt has expired
      var isExpired = await _authController.isTokenValid();
      if (!isExpired) {
        //provide option to continue as guest or log in
        Scaffold.of(context).showBottomSheet(
          (context) =>
              ShoppingCartBottomSheet(message: 'Login session expired'),
        );
      } else {
        //save cart and contnue
        _cartController.saveCart(_cartController.cart);
        Navigator.pushNamed(context, Shipping.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shopping cart",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 1,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20, top: _rightMargin),
            child: Badge(
              padding: EdgeInsets.all(5),
              badgeContent: Text(
                '${context.watch<CartController>().cart.length}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              child: Icon(
                Icons.shopping_cart,
                color: Colors.orange,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 18, right: 18, top: 20),
          //list of items and checkout button
          child: ListView(
            children: [
              //Contine shopping button
              RaisedButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                color: Colors.red[300],
                onPressed: () {
                  Navigator.popUntil(
                    context,
                    (route) => route.settings.name == ProductList.id,
                  );
                },
                child: Text(
                  'CONTINUE SHOPPING',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(
                height: 20.0,
              ),

              Consumer<CartController>(
                builder: (context, cartCtlr, child) {
                  if (cartCtlr.cart.length == 0) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 100,
                          bottom: 10,
                        ),
                        child: Text(
                          'Cart is clean and empty',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: cartCtlr.cart.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Divider(
                              thickness: 2.0,
                              height: 2,
                            ),
                            //particular item
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //Product image
                                Container(
                                  height: 150,
                                  width: 150,
                                  margin: EdgeInsets.only(
                                    right: 18,
                                    bottom: 18,
                                    top: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          '${cartCtlr.cart[index].product.imageUrl}'),
                                      fit: BoxFit.fill,
                                    ),
                                    color: Colors.red,
                                  ),
                                ),

                                //increment/decrement buttons, name,price
                                Column(
                                  children: [
                                    // product name
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 5.0),
                                      child: Text(
                                        '${cartCtlr.cart[index].product.name}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    //product price
                                    Text(
                                        "\$ ${cartCtlr.cart[index].product.price}"),

                                    //increment/decrement buttons,
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        children: [
                                          RoundCartButton(
                                            icon: Icons.remove,
                                            onTap: () {
                                              _handleItemQuantityDecrease(
                                                  cartCtlr.cart[index]);
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '${cartCtlr.cart[index].quantity}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          RoundCartButton(
                                            icon: Icons.add,
                                            onTap: () {
                                              _handleItemQuantityIncrease(
                                                  cartCtlr.cart[index]);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),

                                    //remove from cart button
                                    GestureDetector(
                                      onTap: () {
                                        _handleRemoveCartItem(
                                            cartCtlr.cart[index]);
                                      },
                                      child: CartButton(text: "REMOVE"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      });
                },
              ),

              Divider(
                thickness: 2.0,
                height: 2,
              ),

              SizedBox(
                height: 20.0,
              ),

              //total and checkout button
              Consumer<CartController>(
                builder: (context, cartCtlr, child) {
                  if (cartCtlr.cart.length == 0) {
                    return Visibility(
                      child: Text('empty cart'),
                      visible: false,
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //total
                      RichText(
                        text: TextSpan(
                          text: 'Sub Total: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  '\$ ${context.watch<CartController>().cart.fold(0, (previousValue, element) => previousValue + (element.product.price * element.quantity))}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        width: 15,
                      ),

                      //checkoout button
                      GestureDetector(
                        onTap: () {
                          _checkoutButtonHandler(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 8,
                            bottom: 8,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "CHECKOUT",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
