import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'mini_job_portal.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (database, version) async {
        await database.execute('''
        CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          fullName TEXT,
          address TEXT,
          email TEXT UNIQUE,
          password TEXT
        )
      ''');

        await database.execute('''
        CREATE TABLE applied_jobs(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          email TEXT,
          title TEXT,
          brand TEXT,
          price TEXT
        )
      ''');
      },
    );
  }
}
