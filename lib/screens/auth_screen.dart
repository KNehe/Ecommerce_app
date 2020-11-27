import 'package:ecommerceapp/constants/screen_ids.dart';
import 'package:ecommerceapp/constants/screen_titles.dart';
import 'package:ecommerceapp/constants/tasks.dart';
import 'package:ecommerceapp/controllers/activity_tracker_controller.dart';
import 'package:ecommerceapp/controllers/auth_controller.dart';
import 'package:ecommerceapp/screens/order_history.dart';
import 'package:ecommerceapp/screens/shipping.dart';
import 'package:ecommerceapp/utils/validator.dart';
import 'package:ecommerceapp/widgets/auth_screen_custom_painter.dart';
import 'package:ecommerceapp/widgets/dialog.dart';
import 'package:ecommerceapp/widgets/round_icon_button.dart';
import 'package:ecommerceapp/widgets/underlined_text..dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  //used for navigation using named route
  static String id = AuthScreen_Id;

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

enum AuthScreenId { SignIn_Screen, SignUp_Screen, ForgotPassword_Screen }

class _AuthScreenState extends State<AuthScreen> {
  var _formKey = GlobalKey<FormState>();
  var _screenTitle = SignIn_Screen_Title;
  AuthScreenId _authScreenId = AuthScreenId.SignIn_Screen;

  String _email;
  String _password;
  String _name;

  var _authController;
  CDialog _cDialog;

  @override
  void initState() {
    _authController = AuthController();
    _cDialog = CDialog(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var leftMargin = size.width / 10;

    return Scaffold(
      body: SafeArea(
        child: ListView(children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: size.width,
                    height: size.height / 2.5,
                    child: CustomPaint(
                      painter: AuthScreenCustomPainter(),
                    ),
                  ),
                  Positioned(
                    child: Text(
                      "$_screenTitle",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                    top: size.height / 5,
                    left: leftMargin,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.only(left: leftMargin, right: leftMargin),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: formTextFields() + formButtons(size),
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }

  List<Widget> formTextFields() {
    if (_authScreenId == AuthScreenId.SignIn_Screen) {
      return [
        SizedBox(
          height: 15,
        ),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: "Email",
            hintText: "e.g johndoe@gmail.com",
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          onSaved: (value) => _email = value,
          validator: (value) {
            if (value.isEmpty) {
              return 'Email is required';
            }
            if (!Validator.isEmailValid(value)) {
              return 'Invalid email';
            }
            return null;
          },
          key: ValueKey("sign_up_email_field"),
        ),
        SizedBox(
          height: 15,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Password",
            hintText: "e.g secret",
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          obscureText: true,
          onSaved: (value) => _password = value,
          validator: (value) {
            if (value.isEmpty) {
              return 'Password is required';
            }
            if (value.length < 6) {
              return "Too short";
            }
            return null;
          },
          key: ValueKey("sign_up_password_field"),
        ),
        SizedBox(
          height: 30,
        ),
      ];
    } else if (_authScreenId == AuthScreenId.SignUp_Screen) {
      return [
        TextFormField(
          decoration: InputDecoration(
            labelText: "Name",
            hintText: "e.g John Doe",
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          onSaved: (value) => _name = value,
          validator: (value) {
            if (value.isEmpty) {
              return 'Name is required';
            }

            return null;
          },
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Email",
            hintText: "e.g johndoe@gmail.com",
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          onSaved: (value) => _email = value,
          validator: (value) {
            if (value.isEmpty) {
              return 'Email is required';
            }
            if (!Validator.isEmailValid(value)) {
              return 'Invalid email';
            }
            return null;
          },
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Password",
            hintText: "e.g secret",
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          obscureText: true,
          onSaved: (value) => _password = value,
          validator: (value) {
            if (value.isEmpty) {
              return 'Password is required';
            }
            if (value.length < 6) {
              return "Too short";
            }
            return null;
          },
        ),
        SizedBox(
          height: 20,
        ),
      ];
    }

    return [
      TextFormField(
        decoration: InputDecoration(
          labelText: "Email",
          hintText: "e.g johndoe@gmail.com",
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    ];
  }

  List<Widget> formButtons(size) {
    if (_authScreenId == AuthScreenId.SignIn_Screen) {
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Sign in",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            RoundIconButton(
              width: size.width / 5,
              height: size.width / 5,
              backgroundColor: Color(0xff4b515a),
              iconData: Icons.arrow_forward,
              iconColor: Colors.white,
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();

                  _cDialog.show();

                  if (await _authController.emailAndPasswordSignIn(
                    _email,
                    _password,
                  )) {
                    _cDialog.hide();
                    chooseNextScreen();
                  } else {
                    _cDialog.hide();
                  }
                }
              },
            ),
          ],
        ),
        SizedBox(
          height: 40,
        ),
        //row with forgot password link
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: UnderlinedText(
                text: 'Sign up',
                decorationThickness: 3,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              onTap: () {
                setState(() {
                  _screenTitle = SignUp_Screen_Title;
                  _authScreenId = AuthScreenId.SignUp_Screen;
                });
              },
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _screenTitle = ForgotPassword_Screen_Ttile;
                  _authScreenId = AuthScreenId.ForgotPassword_Screen;
                });
              },
              child: UnderlinedText(
                text: 'Forgot password',
                decorationThickness: 3,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ];
    }

    if (_authScreenId == AuthScreenId.SignUp_Screen) {
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Sign Up",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            RoundIconButton(
              width: size.width / 5.5,
              height: size.width / 5.5,
              backgroundColor: Color(0xff4b515a),
              iconData: Icons.arrow_forward,
              iconColor: Colors.white,
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();

                  _cDialog.show();

                  if (await _authController.emailNameAndPasswordSignUp(
                    _name,
                    _email,
                    _password,
                  )) {
                    _cDialog.hide();
                    chooseNextScreen();
                  } else {
                    _cDialog.hide();
                  }
                }
              },
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        //row with sign in link
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: UnderlinedText(
                text: 'Sign in',
                decorationThickness: 3,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              onTap: () {
                setState(() {
                  _screenTitle = SignIn_Screen_Title;
                  _authScreenId = AuthScreenId.SignIn_Screen;
                });
              },
            ),
          ],
        ),
      ];
    }

    return [
      SizedBox(
        height: 40,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Forgot password",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          RoundIconButton(
            width: size.width / 5.5,
            height: size.width / 5.5,
            backgroundColor: Color(0xff4b515a),
            iconData: Icons.arrow_forward,
            iconColor: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      SizedBox(
        height: 40,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: UnderlinedText(
              text: 'Sign in',
              decorationThickness: 3,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            onTap: () {
              setState(() {
                _screenTitle = SignIn_Screen_Title;
                _authScreenId = AuthScreenId.SignIn_Screen;
              });
            },
          ),
        ],
      ),
    ];
  }

  void chooseNextScreen() async {
    String _currentTask =
        Provider.of<ActivityTracker>(context, listen: false).currentTask;

    switch (_currentTask) {
      case VIEWING_ORDER_HISTORY:
        Navigator.pushReplacementNamed(context, OrderHistroy.id);
        break;
      default:
        Navigator.pushReplacementNamed(context, Shipping.id);
        break;
    }
  }
}
