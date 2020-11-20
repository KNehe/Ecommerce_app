import 'package:flutter/material.dart';

class ProductDetailSkeleton extends StatelessWidget {
  const ProductDetailSkeleton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
            child: Text(''),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 18,
                width: MediaQuery.of(context).size.width / 3,
                color: Colors.grey,
                child: Text(''),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 18,
                width: MediaQuery.of(context).size.width / 3,
                color: Colors.grey,
                child: Text(''),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
            child: Text(''),
          ),
        ],
      ),
    );
  }
}
