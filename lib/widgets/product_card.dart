import 'package:ecommerceapp/models/product.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function onProductTapped;

  const ProductCard({
    Key key,
    @required this.product,
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                bottom: 8.0,
                left: 8.0,
                right: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(product.price.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
