import 'dart:convert';

import 'package:ecommerceapp/services/auth_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthController {
  final storage = FlutterSecureStorage();
  final authService = AuthService();

  saveUserIdAndLoginStatus(
    String userId,
    String isLoggedFlag,
    String jwt,
  ) async {
    await storage.write(key: 'UserId', value: userId);
    await storage.write(key: 'IsLoggedFlag', value: isLoggedFlag);
    await storage.write(key: 'jwt', value: jwt);
  }

  getUserIdAndLoginStatus() async {
    String userId = await storage.read(key: 'UserId');
    String isLoggedFlag = await storage.read(key: 'IsLoggedFlag');
    return [userId, isLoggedFlag];
  }

  deleteUserIdAndLoginStatus() async {
    await storage.deleteAll();
  }

  Future<bool> emailNameAndPasswordSignUp(
      String name, String email, String password) async {
    try {
      var response =
          await authService.emailNameAndPasswordSignUp(name, email, password);

      if (response.statusCode == 201) {
        var jsonResponse = json.decode(response.body);
        var token = jsonResponse['data']['token'];
        var userId = jsonResponse['data']['user']['id'];

        await saveUserIdAndLoginStatus(userId, '1', token);
        return true;
      } else if (response.statusCode == 401) {
        print('error 401 $response');
        return false;
      } else {
        //error show res.body.message
        print('error ${response.body}');
        return false;
      }
    } catch (e) {
      print("Auth service ${e.toString()}");
      return false;
    }
  }

  Future<bool> emailAndPasswordSignIn(String email, String password) async {
    try {
      var response = await authService.emailAndPasswordSignIn(email, password);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var token = jsonResponse['data']['token'];
        var userId = jsonResponse['data']['id'];
        print('$token $userId');
        await saveUserIdAndLoginStatus(userId, '1', token);
        return true;
      } else if (response.statusCode == 401) {
        print('error 401 $response');
        return false;
      } else {
        //error show res.body.message
        print('error ${response.body}');
        return false;
      }
    } catch (e) {
      print("Auth service ${e.toString()}");
      return false;
    }
  }
}
