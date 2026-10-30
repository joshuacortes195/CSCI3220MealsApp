import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

// opens the database once and reuses it after that
final Future<Database> _database = _openDatabase();

// creates the favorites table the first time the app runs
Future<Database> _openDatabase() async {
  // chrome needs the web version of sqlite
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }
  return openDatabase(
    'favorites.db',
    version: 1,
    onCreate: (db, version) {
      return db.execute('CREATE TABLE favorites(id TEXT PRIMARY KEY)'); // only the meal id gets saved
    },
  );
}

// gets the saved meal ids in the order they were favorited
Future<List<String>> loadFavoriteIds() async {
  final db = await _database;
  final rows = await db.query('favorites', orderBy: 'rowid');
  return rows.map((row) => row['id'] as String).toList();
}

// saves a meal id as a favorite
Future<void> addFavorite(String mealId) async {
  final db = await _database;
  await db.insert(
    'favorites',
    {'id': mealId},
    conflictAlgorithm: ConflictAlgorithm.ignore, // skips it if it's already saved
  );
}

// deletes one saved favorite
Future<void> removeFavorite(String mealId) async {
  final db = await _database;
  await db.delete('favorites', where: 'id = ?', whereArgs: [mealId]);
}

// deletes every saved favorite
Future<void> clearFavorites() async {
  final db = await _database;
  await db.delete('favorites');
}
