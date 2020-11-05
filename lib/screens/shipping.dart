import 'package:ecommerceapp/screens/payment_method.dart';
import 'package:flutter/material.dart';

class Shipping extends StatefulWidget {
  Shipping({Key key}) : super(key: key);

  @override
  _ShippingState createState() => _ShippingState();
}

class _ShippingState extends State<Shipping> {
  var _shippingDdetailsFormkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Shipping',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Container(
          margin: EdgeInsets.all(18),
          child: ListView(
            children: [
              Form(
                key: _shippingDdetailsFormkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                        labelText: "Enter Address *",
                        icon: Icon(
                          Icons.place,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                        labelText: "Enter City *",
                        icon: Icon(
                          Icons.location_city,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                        labelText: "Enter Postal Code *",
                        icon: Icon(
                          Icons.local_post_office,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                        labelText: "Enter Country *",
                        icon: Icon(
                          Icons.my_location,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentMethod(),
                          ),
                        );
                      },
                      child: Text(
                        "CONTINUE",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
