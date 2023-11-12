import 'dart:convert';
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseLocal {
  DatabaseLocal._privateConstructor();
  static final DatabaseLocal instance = DatabaseLocal._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    // Si la base de données n'a pas été initialisée, on la crée
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'local_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE galeries(id_image INTEGER PRIMARY KEY,user_id INTEGER, image_data TEXT)',
        );
        // await db.execute('DROP TABLE IF EXISTS galeries');
      },
      
    );
  }




  Future<void> insertData(int userId, String imagePath) async {
    try {
      Database db = await database;
      await db.insert(
          'galeries',
          {'user_id': userId, 'image_data': imagePath},
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
    } catch (e) {
      print('Erreur lors de l\'insertion du chemin d\'image : $e');
    }
  }

  Future<List<Map<String, dynamic>>> getUserImages(int userId) async {
    try {
      Database db = await database;
        List<Map<String, dynamic>> images = await db.query(
          'galeries',
          where: 'user_id = ?',
          whereArgs: [userId],
        );
        return images;
    } catch (e) {
      print('Erreur lors de la récupération des images : $e');
      return [];
    }
  }

  Future<void> deleteImage(int id) async {
  try {
    Database db = await database;
    await db.delete(
      'galeries',
      where: 'id_image = ?',
      whereArgs: [id],
    );
    print('Image supprimée avec succès');
  } catch (e) {
    print('Erreur lors de la suppression de l\'image : $e');
  }
}
Future<void> deleteMultipleImages(List<int> imageIds) async {
    try {
      Database db = await database;
      await db.delete(
        'galeries',
        where: 'id_image IN (${imageIds.map((id) => '?').join(', ')})',
        whereArgs: imageIds,
      );
      print('Images supprimées avec succès');
    } catch (e) {
      print('Erreur lors de la suppression des images : $e');
    }
  }

}


