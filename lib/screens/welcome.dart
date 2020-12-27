import 'package:flutter/material.dart';
import 'package:reqres_api_task/constants.dart';
import 'package:reqres_api_task/screens/login.dart';

class WelcomePage extends StatefulWidget {
  static String routeName = '/welcome';
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Widget _loginButton(double width) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, LoginPage.routeName);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: kGradientEnd.withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.white),
        child: Text(
          'Login',
          style: TextStyle(fontSize: width * 0.05, color: kGradientEnd),
        ),
      ),
    );
  }

  Widget _title(double width) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'W',
          style: TextStyle(
            fontSize: width * 0.1,
            fontFamily: 'Port Lligat Sans',
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: 'el',
              style: TextStyle(color: Colors.black, fontSize: width * 0.1),
            ),
            TextSpan(
              text: 'come',
              style: TextStyle(color: Colors.white, fontSize: width * 0.1),
            ),
          ]),
    );
  }

  Widget _subTitle(double width) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Please Login to continue',
        style: TextStyle(
            fontSize: width * 0.05,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontFamily: 'Port Lligat Sans'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 100),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [kGradientStart, kGradientEnd])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _title(width),
              SizedBox(
                height: height * 0.09,
              ),
              _subTitle(width),
              SizedBox(
                height: height * 0.04,
              ),
              _loginButton(width),
            ],
          ),
        ),
      ),
    );
  }
}
