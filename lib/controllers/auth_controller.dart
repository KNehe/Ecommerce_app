import 'dart:convert';
import 'dart:io';

import 'package:ecommerceapp/controllers/error_controller.dart';
import 'package:ecommerceapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthController {
  final storage = FlutterSecureStorage();
  final _authService = AuthService();

  saveUserDataAndLoginStatus(
    String userId,
    String isLoggedFlag,
    String jwt,
    String email,
    String name,
  ) async {
    await storage.write(key: 'UserId', value: userId);
    await storage.write(key: 'IsLoggedFlag', value: isLoggedFlag);
    await storage.write(key: 'jwt', value: jwt);
    await storage.write(key: 'email', value: email);
    await storage.write(key: 'name', value: name);
  }

  getUserDataAndLoginStatus() async {
    String userId = await storage.read(key: 'UserId');
    String isLoggedFlag = await storage.read(key: 'IsLoggedFlag');
    String token = await storage.read(key: 'jwt');
    String email = await storage.read(key: 'email');
    String name = await storage.read(key: 'name');
    return [userId, isLoggedFlag, token, email, name];
  }

  deleteUserDataAndLoginStatus() async {
    await storage.deleteAll();
  }

  Future<bool> emailNameAndPasswordSignUp(
    String name,
    String email,
    String password,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) async {
    try {
      var response =
          await _authService.emailNameAndPasswordSignUp(name, email, password);

      if (response.statusCode == 201) {
        var jsonResponse = json.decode(response.body);
        var token = jsonResponse['data']['token'];
        var userId = jsonResponse['data']['user']['id'];
        var email = jsonResponse['data']['user']['email'];
        var name = jsonResponse['data']['user']['name'];

        await saveUserDataAndLoginStatus(userId, '1', token, email, name);
        return true;
      } else {
        ErrorController.showErrorFromApi(scaffoldKey, response);
        return false;
      }
    } on SocketException catch (_) {
      ErrorController.showNoInternetError(scaffoldKey);
      return false;
    } on HttpException catch (_) {
      ErrorController.showNoServerError(scaffoldKey);
      return false;
    } catch (e) {
      print("Error ${e.toString()}");
      ErrorController.showFlutterError(scaffoldKey, e);
      return false;
    }
  }

  Future<bool> emailAndPasswordSignIn(
    String email,
    String password,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) async {
    try {
      var response = await _authService.emailAndPasswordSignIn(email, password);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var token = jsonResponse['data']['token'];
        var userId = jsonResponse['data']['user']['id'];
        var email = jsonResponse['data']['user']['email'];
        var name = jsonResponse['data']['user']['name'];

        await saveUserDataAndLoginStatus(userId, '1', token, email, name);
        return true;
      } else {
        ErrorController.showErrorFromApi(scaffoldKey, response);
        return false;
      }
    } on SocketException catch (_) {
      ErrorController.showNoInternetError(scaffoldKey);
      return false;
    } on HttpException catch (_) {
      ErrorController.showNoServerError(scaffoldKey);
      return false;
    } catch (e) {
      print("Error ${e.toString()}");
      ErrorController.showFlutterError(scaffoldKey, e);
      return false;
    }
  }

  Future<bool> isTokenValid() async {
    String token = await storage.read(key: 'jwt');

    if (token == null || token.isEmpty) {
      return false;
    }
    var response = await _authService.checkTokenExpiry(token);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> changeName(
      String name, GlobalKey<ScaffoldState> scaffoldKey) async {
    try {
      var data = await getUserDataAndLoginStatus();

      var response = await _authService.changeName(name, data[0], data[2]);

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        await storage.write(key: 'name', value: responseBody['data']['name']);

        return true;
      } else {
        ErrorController.showErrorFromApi(scaffoldKey, response);
        return false;
      }
    } on SocketException catch (_) {
      ErrorController.showNoInternetError(scaffoldKey);
      return false;
    } on HttpException catch (_) {
      ErrorController.showNoServerError(scaffoldKey);
      return false;
    } catch (e) {
      print("Error ${e.toString()}");
      ErrorController.showFlutterError(scaffoldKey, e);
      return false;
    }
  }

  Future<bool> changeEmail(
      String email, GlobalKey<ScaffoldState> scaffoldKey) async {
    try {
      var data = await getUserDataAndLoginStatus();

      var response = await _authService.changeEmail(email, data[0], data[2]);

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        await storage.write(key: 'email', value: responseBody['data']['email']);
        return true;
      } else {
        ErrorController.showErrorFromApi(scaffoldKey, response);
        return false;
      }
    } on SocketException catch (_) {
      ErrorController.showNoInternetError(scaffoldKey);
      return false;
    } on HttpException catch (_) {
      ErrorController.showNoServerError(scaffoldKey);
      return false;
    } catch (e) {
      print("Error ${e.toString()}");
      ErrorController.showFlutterError(scaffoldKey, e);
      return false;
    }
  }

  Future<bool> forgotPassword(
      String email, GlobalKey<ScaffoldState> scaffoldKey) async {
    try {
      print("init mail $email");
      var response = await _authService.forgotPassword(email);

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);

        scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.red[900],
          content: Text(
            '${responseBody['message']}',
            style: TextStyle(fontSize: 15),
          ),
        ));

        return true;
      } else {
        ErrorController.showErrorFromApi(scaffoldKey, response);
        return false;
      }
    } on SocketException catch (_) {
      ErrorController.showNoInternetError(scaffoldKey);
      return false;
    } on HttpException catch (_) {
      ErrorController.showNoServerError(scaffoldKey);
      return false;
    } catch (e) {
      print("Error ${e.toString()}");
      ErrorController.showFlutterError(scaffoldKey, e);
      return false;
    }
  }
}
