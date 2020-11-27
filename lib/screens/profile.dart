import 'package:ecommerceapp/constants/screen_ids.dart';
import 'package:ecommerceapp/constants/screen_titles.dart';
import 'package:ecommerceapp/constants/tasks.dart';
import 'package:ecommerceapp/controllers/auth_controller.dart';
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

  @override
  void initState() {
    _authController = AuthController();
    super.initState();
  }

  Future<bool> getTokenValidity() async {
    return await _authController.isTokenValid();
  }

  Future<List<String>> getLoginStatus() async {
    return await _authController.getUserDataAndLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              future: Future.wait([getTokenValidity(), getLoginStatus()]),
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
                return Text('This is your profile');
              },
            ),
          ],
        ),
      ),
    );
  }
}
