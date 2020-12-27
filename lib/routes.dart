import 'package:flutter/material.dart';
import 'package:reqres_api_task/screens/home.dart';
import 'package:reqres_api_task/screens/login.dart';
import 'package:reqres_api_task/screens/welcome.dart';

final Map<String, WidgetBuilder> routes = {
  WelcomePage.routeName: (context) => WelcomePage(),
  LoginPage.routeName: (context) => LoginPage(),
  HomePage.routeName: (context) => HomePage(),
};
