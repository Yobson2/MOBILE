import 'package:flutter/material.dart';
import 'package:flutter_notabene/routes/app_routes.dart';
import 'package:flutter_notabene/services/connectEtat.dart';
import 'package:provider/provider.dart';

void main() {
  
  runApp(
     ChangeNotifierProvider(
      create: (context) => UserProvider(),
       child: MyApp(),
    ),
  );
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

