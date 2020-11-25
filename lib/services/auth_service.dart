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
}
