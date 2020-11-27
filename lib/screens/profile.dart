import 'package:ecommerceapp/constants/screen_ids.dart';
import 'package:ecommerceapp/constants/screen_titles.dart';
import 'package:ecommerceapp/constants/tasks.dart';
import 'package:ecommerceapp/controllers/auth_controller.dart';
import 'package:ecommerceapp/screens/products_list.dart';
import 'package:ecommerceapp/utils/validator.dart';
import 'package:ecommerceapp/widgets/dialog.dart';
import 'package:ecommerceapp/widgets/guest_user_drawer_widget.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);
  static String id = ProfileScreen_id;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var _authController;
  String _name;
  String _email;
  final _saveNameFormKey = GlobalKey<FormState>();
  var _dialog;

  @override
  void initState() {
    _authController = AuthController();
    super.initState();
  }

  Future<bool> _getTokenValidity() async {
    return await _authController.isTokenValid();
  }

  Future<List<String>> _getLoginStatus() async {
    return await _authController.getUserDataAndLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    _dialog = CDialog(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "$ProfileScreen_Title",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            FutureBuilder(
              future: Future.wait([_getTokenValidity(), _getLoginStatus()]),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 3),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                var isLoggedInFlag = snapshot.data[1][1];
                var isTokenValid = snapshot.data[0];
                var email = snapshot.data[1][3];
                var name = snapshot.data[1][4];

                //when user is not signed in
                if (isLoggedInFlag == null || isLoggedInFlag == '0') {
                  return GuestUserDrawerWidget(
                    message: 'Sign in to see profile',
                    currentTask: VIEWING_PROFILE,
                  );
                }

                //when user token has expired
                if (!isTokenValid) {
                  return GuestUserDrawerWidget(
                    message: 'Session expired. Sign in to see profile',
                    currentTask: VIEWING_PROFILE,
                  );
                }

                //user is logged in and token is valid
                return Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    //avatar
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.width / 3,
                      child: CircleAvatar(
                        backgroundColor: Colors.orange[100],
                        child: Icon(
                          Icons.person_outline,
                          size: MediaQuery.of(context).size.width / 4,
                          color: Colors.orange,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    //personal detail labels and their value
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          //name value
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '$name',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    _handleEditIconClick(
                                        context, CHANGING_NAME);
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.orange,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 3,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          //email value
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '$email',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    _handleEditIconClick(
                                        context, CHANGING_EMAIL);
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.orange,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 3,
                          ),

                          SizedBox(height: 10),
                          //logout button
                          RaisedButton(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            color: Colors.orange,
                            onPressed: () {
                              _handleSignOutCall();
                            },
                            child: Text(
                              'Sign out',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _handleEditIconClick(BuildContext context, String task) async {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              color: Colors.grey[200],
              //form having either email or name field and save button
              child: Form(
                key: _saveNameFormKey,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: task == CHANGING_NAME
                          //name field
                          ? TextFormField(
                              decoration: InputDecoration(
                                labelText: "Name",
                                hintText: "e.g John Doe",
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
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
                            )
                          //email field
                          : TextFormField(
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
                    ),
                    SizedBox(height: 10),
                    //save buttton
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 8.0),
                      child: ButtonTheme(
                        minWidth: 100,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          color: Colors.orange,
                          onPressed: () async {
                            if (_saveNameFormKey.currentState.validate()) {
                              _saveNameFormKey.currentState.save();
                              _dialog.show();

                              if (task == CHANGING_NAME &&
                                  await _authController.changeName(_name)) {
                                resetProfileScreen();
                              } else if (task == CHANGING_EMAIL &&
                                  await _authController.changeEmail(_email)) {
                                resetProfileScreen();
                              } else {
                                _dialog.hide();
                              }
                            }
                          },
                          child: Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void resetProfileScreen() {
    setState(() {
      _getLoginStatus();
      _getTokenValidity();
    });
    _saveNameFormKey.currentState.reset();
    Navigator.pop(context);
    _dialog.hide();
  }

  _handleSignOutCall() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          //Confirm sign out button
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: Colors.orange,
              onPressed: () async {
                _dialog.show();
                await _authController.deleteUserDataAndLoginStatus();
                _dialog.hide();
                Navigator.pushReplacementNamed(context, ProductList.id);
              },
              child: Text(
                'Confirm sign out',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          );
        });
  }
}
