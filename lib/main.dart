import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:reqres_api_task/provider/provider.dart';
import 'package:reqres_api_task/routes.dart';
import 'package:reqres_api_task/screens/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: MaterialApp(
        title: 'Reqres API Task',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Port Lligat Sans',
        ),
        home: WelcomePage(),
        builder: EasyLoading.init(),
        routes: routes,
      ),
    );
  }
}
