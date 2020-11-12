import 'package:ecommerceapp/screens/thank_you.dart';
import 'package:ecommerceapp/services/stripe_service.dart';
import 'package:flutter/material.dart';

class PaymentDetails extends StatefulWidget {
  PaymentDetails({Key key}) : super(key: key);

  @override
  _PaymentDetailsState createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Payment details',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 1,
            backgroundColor: Colors.white,
          ),
          body: ListView(
            children: [
              Container(
                margin: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    //Card holder's name
                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Card Holder Name",
                        icon: Icon(
                          Icons.person,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    //card number
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Card Number",
                        icon: Icon(
                          Icons.credit_card,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //expiry year
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Exp month",
                              icon: Icon(
                                Icons.date_range,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        //expiry year
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Exp year",
                              icon: Icon(
                                Icons.date_range,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        //cvc
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "CVC",
                              icon: Icon(
                                Icons.security,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),

                    Text(
                      "Payment amount: \$ 24000",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(
                      height: 35,
                    ),

                    //payment button
                    ButtonTheme(
                      minWidth: size.width,
                      child: RaisedButton(
                        color: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        onPressed: () async {
                          var result = await StripeService.processPayment(
                              '40000', 'usd');
                          if (result.success) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Thanks(),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "PAY",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
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
