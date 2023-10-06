import 'package:flutter/material.dart';
import 'package:flutter_notabene/gestion/session.dart';
import 'package:flutter_notabene/routes/app_routes.dart';
import 'package:flutter_notabene/sqlite_bd/config.dart';
import 'package:sqflite/sqflite.dart';

SessionManager mainSession = SessionManager();
DatabaseLocal database = DatabaseLocal.instance;


void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialiser la base de données
    await database.initDatabase(); 

    // Vérifier la base de données
    Database? db = await DatabaseLocal.instance.database;

    if (db != null) {
      print('La base de données a été créée et vous êtes connecté.');
    } else {
      print('Il y a eu un problème lors de la création ou de la connexion à la base de données.');
      return; 
    }
    mainSession.init();

    runApp(
      MyApp(),
    );
  } catch (e) {
    print('Erreur lors de l\'initialisation : $e');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
