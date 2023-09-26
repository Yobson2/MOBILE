import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseLocal {
  
  late Database _database;

  Future<void> initDatabase() async {
    if (_database != null) return;
    _database = await openDatabase(
      join(await getDatabasesPath(), 'notabene_database.db'),
      version: 1,
      // onCreate: (db, version) {
      //   db.execute(
      //     'CREATE TABLE utilisateurs(id INTEGER PRIMARY KEY,id_session TEXT,id_utilisateur int, nom_utilisateur TEXT,mot_de_passe TEXT,adresse_email TEXT,photo_user TEXT,id_Localisation INTEGER,)',
      //   );
      //   // db.execute(
      //   //   'CREATE TABLE entreprises(id INTEGER PRIMARY KEY, autre_colonne TEXT)',
      //   // );
      // },
    );
  }

  Future<void> insertData(Map<String, dynamic> data, String tableName) async {
    await _database.insert(tableName, data);
  }

  Future<List<Map<String, dynamic>>> getData(String tableName) async {
    return await _database.query(tableName);
  }
}
