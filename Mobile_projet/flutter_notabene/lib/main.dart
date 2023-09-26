import 'package:flutter/material.dart';
import 'package:flutter_notabene/gestion/session.dart';
import 'package:flutter_notabene/routes/app_routes.dart';
import 'package:flutter_notabene/sqlite_bd/config.dart';


SessionManager mainSession= SessionManager();
DatabaseLocal database = DatabaseLocal();


void main() async { 
    mainSession.init();
    //  WidgetsFlutterBinding.ensureInitialized();

    // Initialisation de la base de données
    // await database.initDatabase();
  runApp(
    MyApp(),
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

