import 'dart:convert';

import 'package:flutter/material.dart';

class ErrorController {
  static showErrorFromApi(GlobalKey<ScaffoldState> scaffoldKey, var response) {
    var resBody = json.decode(response.body);
    String message = ErrorController()._formatErrorFromApi(resBody['message']);
    ErrorController()._showErrorSnackbar(scaffoldKey, message);
  }

  static showNoInternetError(GlobalKey<ScaffoldState> scaffoldKey) {
    ErrorController()._showErrorSnackbar(scaffoldKey, 'No internet connection');
  }

  static showNoServerError(GlobalKey<ScaffoldState> scaffoldKey) {
    ErrorController()._showErrorSnackbar(scaffoldKey, 'Failed to reach server');
  }

  static showFlutterError(GlobalKey<ScaffoldState> scaffoldKey, Error e) {
    ErrorController()._showErrorSnackbar(scaffoldKey, '${e.toString()}');
  }

  _showErrorSnackbar(GlobalKey<ScaffoldState> scaffoldKey, String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.red[900],
      content: Text(
        '$message',
        style: TextStyle(fontSize: 15),
      ),
    ));
  }

  _formatErrorFromApi(String message) {
    switch (message) {
      case 'Jwt token is invalid':
        return message = 'Authentication failed';
        break;
      default:
        return message;
    }
  }
}
