import 'package:ecommerceapp/screens/order_history.dart';
import 'package:flutter/material.dart';

class CDrawer extends StatefulWidget {
  CDrawer({Key key}) : super(key: key);

  @override
  _CDrawerState createState() => _CDrawerState();
}

class _CDrawerState extends State<CDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image(
              image: AssetImage("assets/images/logo.png"),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: ListTile(
              tileColor: Colors.grey[200],
              leading: Icon(Icons.person),
              trailing: Icon(Icons.people),
              title: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: ListTile(
              tileColor: Colors.grey[200],
              leading: Icon(Icons.history),
              trailing: Icon(Icons.history_edu),
              title: Text(
                'Order history',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, OrderHistroy.id);
              },
            ),
          ),
        ],
      ),
    );
  }
}
