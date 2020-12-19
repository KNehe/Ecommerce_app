import 'dart:ui';
import 'package:ecommerceapp/constants/screen_ids.dart';
import 'package:ecommerceapp/screens/shopping_cart.dart';
import 'package:badges/badges.dart';
import 'package:ecommerceapp/controllers/cart_controller.dart';
import 'package:ecommerceapp/skeletons/product_detail_skeleton.dart';
import 'package:ecommerceapp/widgets/cart_button.dart';
import 'package:ecommerceapp/widgets/product_detail_bottomsheet_content.dart';
import 'package:ecommerceapp/widgets/round_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({Key key}) : super(key: key);
  static String id = ProductDetail_Screen_Id;

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  var _cartCtlr;

  @override
  void initState() {
    super.initState();
    _cartCtlr = Provider.of<CartController>(context, listen: false);
  }

  _handleButtonTap(context) {
    if (!_cartCtlr.isItemInCart(_cartCtlr.selectedItem)) {
      _cartCtlr.addToCart(_cartCtlr.selectedItem);
    } else {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) =>
            ProductDetailBottomSheetContent(cartCtlr: _cartCtlr),
      );
    }
  }

  _handleQuantityIncrease() {
    _cartCtlr.increaseCartItemAndProductDetailItemQuantity();
  }

  _handleQuantityDecrease() {
    _cartCtlr.decreaseCartItemAndProductDetailItemQuantity();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double _leftMargin = 18;
    double _rightMargin = 10;

    return Scaffold(
      appBar: AppBar(
        title: Consumer<CartController>(
          builder: (context, cartCtlr, child) {
            if (!cartCtlr.isLoadingProduct) {
              return Text(
                "${cartCtlr.selectedItem.product.category}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              );
            }
            return Text('Loading ...');
          },
        ),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20, top: _rightMargin),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ShoppingCart.id);
              },
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
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Consumer<CartController>(
          builder: (context, cartCtlr, child) {
            if (cartCtlr.isLoadingProduct) {
              return Center(
                child: Shimmer.fromColors(
                  child: ProductDetailSkeleton(),
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[400],
                ),
              );
            }
            return ListView(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(left: _leftMargin, right: _rightMargin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //product image
                      Container(
                        height: size.width / 2 + 100,
                        width: size.width,
                        child: Image.network(
                          cartCtlr.selectedItem.product.imageUrl,
                          fit: BoxFit.fill,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace stackTrace) {
                            return Center(child: Icon(Icons.error));
                          },
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(
                        height: 30,
                      ),

                      //product name and price
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${cartCtlr.selectedItem.product.name}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Text(
                              "\$${cartCtlr.selectedItem.product.price}",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),

                      Divider(
                        thickness: 3,
                      ),
                      // increment and decrement buttons, add to cart button
                      Container(
                        color: Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // quantity ,increment,and decrement buttons
                              Row(
                                children: [
                                  //decrement button
                                  RoundCartButton(
                                    icon: Icons.remove,
                                    width: size.width * 0.1,
                                    onTap: () {
                                      _handleQuantityDecrease();
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    // quantity
                                    child: Text(
                                      '${context.watch<CartController>().selectedItem.quantity}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  // increment button
                                  RoundCartButton(
                                    icon: Icons.add,
                                    width: size.width * 0.1,
                                    onTap: () {
                                      _handleQuantityIncrease();
                                    },
                                  ),
                                ],
                              ),

                              //add to cart button
                              InkWell(
                                onTap: () {
                                  _handleButtonTap(context);
                                },
                                child: CartButton(
                                  text: "ADD",
                                  width: size.width * 0.2,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 3,
                      ),

                      SizedBox(
                        height: 30,
                      ),

                      //Details
                      Text(
                        "Details",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${cartCtlr.selectedItem.product.details}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.justify,
                      ),

                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
