import 'package:flutter/material.dart';
import 'package:flutter_notabene/routes/app_routes.dart';
// import 'package:flutter_notabene/screens/Sign_screen.dart';
// import 'package:flutter_notabene/screens/home_screem.dart';
// import 'package:flutter_notabene/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),
      initialRoute:AppRoutes.login,
      onGenerateRoute:AppRoutes.generateRoute,
    );
  }
}

