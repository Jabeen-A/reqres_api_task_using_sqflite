import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reqres_api_task/constants.dart';
import 'package:reqres_api_task/models/login.dart';
import 'package:http/http.dart' as http;
import 'package:reqres_api_task/provider/provider.dart';
import 'package:reqres_api_task/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  static login(Login login, BuildContext context) async {
    double width = MediaQuery.of(context).size.width;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print('Email: ${login.email}, Password: ${login.password}');

    var loginResponse = await http.post(kLoginURL, body: login.toJson());
    var jsonLoginResponse = jsonDecode(loginResponse.body);

    print(loginResponse.body);

    if (loginResponse.statusCode == 200) {
      preferences.setString("userToken", jsonLoginResponse['token']);
      print(jsonLoginResponse['token']);
      AppProvider appProvider = AppProvider();
      appProvider.getUsers();
      Fluttertoast.showToast(
          msg: 'User logged in successfully',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.green,
          fontSize: width * 0.03,
          textColor: Colors.white);
      EasyLoading.dismiss();
      Navigator.pushNamedAndRemoveUntil(
          context, HomePage.routeName, (route) => false);
    } else {
      print(jsonLoginResponse['error']);
      EasyLoading.dismiss();
      Fluttertoast.showToast(
          msg: jsonLoginResponse['error'],
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          fontSize: width * 0.03,
          textColor: Colors.white);
    }
  }
}
