import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const search_table = 'recent_search';
const book_table = 'book';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    String path = join(await getDatabasesPath(), 'book_tracker.db');
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: initDB,
    );
    return database;
  }

  void initDB(Database database, int version) async {
    await database.execute(
      '''CREATE TABLE IF NOT EXISTS $search_table(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        search TEXT,
      )''',
    );

    await database.execute(
      '''CREATE TABLE IF NOT EXISTS $book_table(
        id TEXT PRIMARY KEY NOT NULL,
        title TEXT NOT NULL DEFAULT '',
        authors TEXT NOT NULL DEFAULT '',
        publishedDateTimestamp INT NOT NULL DEFAULT 0,
        description TEXT NOT NULL DEFAULT '',
        pageCount INT NOT NULL DEFAULT 0,
        averageRating DOUBLE DEFAULT 0,
        categories TEXT NOT NULL DEFAULT '',
        ratingsCount DOUBLE NOT NULL DEFAULT 0,
        thumbnail TEXT,
      )'''
    );
  }
}
