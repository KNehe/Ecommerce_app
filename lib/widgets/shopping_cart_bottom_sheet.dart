import 'package:ecommerceapp/screens/auth_screen.dart';
import 'package:ecommerceapp/screens/shipping.dart';
import 'package:flutter/material.dart';

class ShoppingCartBottomSheet extends StatelessWidget {
  const ShoppingCartBottomSheet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[300],
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            color: Colors.red[900],
            onPressed: () {
              Navigator.pushNamed(context, AuthScreen.id);
            },
            child: Text(
              'Sign In',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'OR',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            color: Colors.orange[900],
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, Shipping.id);
            },
            child: Text(
              'Continue as Guest',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
