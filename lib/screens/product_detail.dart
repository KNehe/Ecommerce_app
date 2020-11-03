import 'package:ecommerceapp/screens/shopping_cart.dart';
import 'package:ecommerceapp/widgets/cart_button.dart';
import 'package:ecommerceapp/widgets/round_cart_button.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double _leftMargin = 18;
    double _rightMargin = 10;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Food",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
          ),
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
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(left: _leftMargin, right: _rightMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //product image
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                        image: AssetImage("assets/images/fish.jpg"),
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
                          "Fish",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          "\$100",
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
                                icon: Icons.remove,
                                onTap: () {},
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '1',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              RoundCartButton(
                                icon: Icons.add,
                                onTap: () {},
                              ),
                            ],
                          ),

                          //add to cart button
                          CartButton(
                            text: "ADD",
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
                    "Enjoy the best fish avaialable with your family. Fish is very rich in proteins.Enjoy the best fish avaialable with your family. Fish is very rich in proteins.Enjoy the best fish avaialable with your family. Fish is very rich in proteins.Enjoy the best fish avaialable with your family. Fish is very rich in proteins/Enjoy the best fish avaialable with your family. Fish is very rich in proteins",
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
        ),
      ),
    );
  }
}
