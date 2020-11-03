import 'package:ecommerceapp/screens/shipping.dart';
import 'package:ecommerceapp/widgets/cart_button.dart';
import 'package:ecommerceapp/widgets/round_cart_button.dart';
import 'package:flutter/material.dart';

List<String> _products = [
  "Fish",
  "Cake",
  "Fish",
  "Cake",
];

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({Key key}) : super(key: key);

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
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.orange,
            ),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 18, right: 18, top: 10),
          //list of items and checkout button
          child: ListView(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: _products.length,
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
                                  image: index % 2 == 0
                                      ? AssetImage("assets/images/fish.jpg")
                                      : AssetImage("assets/images/cake.jpg"),
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
                                    _products[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                //product price
                                Text("\$100"),

                                //increment/decrement buttons,
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      RoundCartButton(
                                        icon: Icons.remove,
                                        onTap: () {},
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '1',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      RoundCartButton(
                                        icon: Icons.add,
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                ),

                                //remove from cart button
                                CartButton(text: "REMOVE"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  }),

              Divider(
                thickness: 2.0,
                height: 2,
              ),
              SizedBox(
                height: 15.0,
              ),

              //total and checkout button
              Row(
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
                          text: '\$1000',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Shipping(),
                        ),
                      );
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
