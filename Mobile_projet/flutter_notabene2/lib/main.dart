import 'package:flutter/material.dart';
import 'package:flutter_notabene2/routes/app_routes.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),
      initialRoute:AppRoutes.home,
      onGenerateRoute:AppRoutes.generateRoute,
    );
  }
}

