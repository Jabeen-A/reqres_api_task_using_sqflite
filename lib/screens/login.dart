import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:reqres_api_task/components/container.dart';
import 'package:reqres_api_task/constants.dart';
import 'package:reqres_api_task/controller/login_controller.dart';
import 'package:reqres_api_task/models/login.dart';

class LoginPage extends StatefulWidget {
  static String routeName = '/login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Widget _backButton(double width) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(
                    fontSize: width * 0.05, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _submitButton(double width) {
    return FlatButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onPressed: () {
        if (_formKey.currentState.validate()) {
          EasyLoading.show(status: 'Logging in...');
          Login login = Login(
              email: _emailController.text, password: _passwordController.text);
          LoginController.login(login, context);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kGradientEnd,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
        ),
        child: Text(
          'Login',
          style: TextStyle(fontSize: width * 0.05, color: Colors.white),
        ),
      ),
    );
  }

  Widget _title(double width) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'L',
          style: TextStyle(
              fontSize: width * 0.1,
              fontWeight: FontWeight.w700,
              color: kGradientEnd,
              fontFamily: 'Port Lligat Sans'),
          children: [
            TextSpan(
              text: 'og',
              style: TextStyle(color: Colors.black, fontSize: width * 0.1),
            ),
            TextSpan(
              text: 'in',
              style: TextStyle(color: kGradientEnd, fontSize: width * 0.1),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .3),
                    _title(width),
                    SizedBox(height: height * 0.05),
                    TextFormField(
                      controller: _emailController,
                      decoration: new InputDecoration(
                        labelText: "Email",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Email cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    TextFormField(
                      controller: _passwordController,
                      decoration: new InputDecoration(
                        labelText: "Password",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Password cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: height * 0.05),
                    _submitButton(width),
                  ],
                ),
              ),
            ),
          ),
          Positioned(top: height * 0.05, left: 0, child: _backButton(width)),
        ],
      ),
    ));
  }
}
