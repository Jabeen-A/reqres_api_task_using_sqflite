import 'package:meta/meta.dart';
import 'dart:convert';

class Login {
  Login({
    @required this.email,
    @required this.password,
  });

  final String email;
  final String password;

  factory Login.fromRawJson(String str) => Login.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
