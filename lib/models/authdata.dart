class AuthData {
  String name;
  String email;
  String password;

  AuthData({this.name, this.email, this.password});

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
      };
}
