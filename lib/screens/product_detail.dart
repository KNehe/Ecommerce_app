import 'package:ecommerceapp/controllers/product_controller.dart';
import 'package:ecommerceapp/screens/shopping_cart.dart';
import 'package:ecommerceapp/skeletons/product_detail_skeleton.dart';
import 'package:ecommerceapp/widgets/cart_button.dart';
import 'package:ecommerceapp/widgets/round_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({Key key}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double _leftMargin = 18;
    double _rightMargin = 10;

    return Scaffold(
      appBar: AppBar(
        title: Consumer<ProductController>(
          builder: (context, ctlr, child) {
            return Text(
              "${ctlr.selectedProduct.category}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
              ),
            );
          },
        ),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.orange,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoppingCart(),
                ),
              );
            },
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Consumer<ProductController>(
          builder: (context, productCtlr, child) {
            if (productCtlr.isLoadingProduct) {
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
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                productCtlr.selectedProduct.imageUrl),
                            fit: BoxFit.fill,
                          ),
                        ),
                        height: size.width / 2 + 100,
                        width: size.width,
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
                              "${productCtlr.selectedProduct.name}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Text(
                              "\$${productCtlr.selectedProduct.price}",
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
                              // increment and decrement buttons
                              Row(
                                children: [
                                  RoundCartButton(
                                      icon: Icons.remove, onTap: () => {}),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '20',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  RoundCartButton(
                                    icon: Icons.add,
                                    onTap: () => {},
                                  ),
                                ],
                              ),

                              //add to cart button
                              InkWell(
                                onTap: () => {},
                                child: CartButton(
                                  text: "ADD",
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
                        "${productCtlr.selectedProduct.details}",
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
