import 'package:ecommerceapp/constants/tasks.dart';
import 'package:ecommerceapp/controllers/activity_tracker_controller.dart';
import 'package:ecommerceapp/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GuestUserOrderHistoryWidget extends StatelessWidget {
  final String message;
  const GuestUserOrderHistoryWidget({Key key, @required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
      child: Column(
        children: [
          Text(
            '$message',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          ButtonTheme(
            minWidth: 150,
            child: RaisedButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              color: Colors.orange,
              onPressed: () {
                Provider.of<ActivityTracker>(context, listen: false)
                    .setTaskCurrentTask(VIEWING_ORDER_HISTORY);
                Navigator.pushReplacementNamed(context, AuthScreen.id);
              },
              child: Text(
                'SIGN IN',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
