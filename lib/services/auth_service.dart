import 'dart:convert';

import 'package:ecommerceapp/application.properties/app_properties.dart';
import 'package:ecommerceapp/models/authdata.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static AuthService _authService;

  AuthService._internal() {
    _authService = this;
  }

  factory AuthService() => _authService ?? AuthService._internal();

  static var httpClient = http.Client();

  Map<String, String> headers = {'Content-Type': 'application/json'};

  Future emailNameAndPasswordSignUp(
    String name,
    String email,
    String password,
  ) async {
    var authData = AuthData(name: name, email: email, password: password);

    return await http.post(
      AppProperties.signUpUrl,
      body: json.encode(authData.toJson()),
      headers: headers,
    );
  }

  Future emailAndPasswordSignIn(
    String email,
    String password,
  ) async {
    var authData = AuthData(name: '', email: email, password: password);

    return await http.post(
      AppProperties.signInUrl,
      body: json.encode(authData.toJson()),
      headers: headers,
    );
  }

  Future checkTokenExpiry(String token) async {
    var tokenObject = Map<String, String>();
    tokenObject.putIfAbsent('token', () => token);

    return await http.post(
      AppProperties.checkTokenExpiryUrl,
      body: json.encode(tokenObject),
      headers: headers,
    );
  }

  Future changeName(String name, String userId, String jwtToken) async {
    headers.putIfAbsent('Authorization', () => 'Bearer $jwtToken');
    var bodyObject = Map<String, String>();
    bodyObject.putIfAbsent('name', () => name);

    return await http.patch(
      "${AppProperties.changenameUrl}$userId",
      headers: headers,
      body: json.encode(bodyObject),
    );
  }

  Future changeEmail(String email, String userId, String jwtToken) async {
    headers.putIfAbsent('Authorization', () => 'Bearer $jwtToken');
    var bodyObject = Map<String, String>();
    bodyObject.putIfAbsent('email', () => email);

    return await http.patch(
      "${AppProperties.changeMailUrl}$userId",
      headers: headers,
      body: json.encode(bodyObject),
    );
  }

  Future forgotPassword(String email) async {
    var bodyObject = Map<String, String>();
    bodyObject.putIfAbsent('email', () => email);
    print('email: $email');
    return await http.post(
      "${AppProperties.forgotPasswordUrl}",
      headers: headers,
      body: json.encode(bodyObject),
    );
  }
}
