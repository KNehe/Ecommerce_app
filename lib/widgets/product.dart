import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  final Image productImage;
  final String productName;
  final String productPrice;
  final Function onProductTapped;

  const Product({
    Key key,
    @required this.productImage,
    @required this.productName,
    @required this.productPrice,
    @required this.onProductTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onProductTapped,
      child: Container(
        color: Colors.grey[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            productImage,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    productName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(productPrice),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
