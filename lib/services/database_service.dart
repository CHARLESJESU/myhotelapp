import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    String path = join(await getDatabasesPath(), 'user_database.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS users (
            userid INTEGER PRIMARY KEY,
            username TEXT NOT NULL,
            useremail TEXT UNIQUE NOT NULL,
            phoneNumber TEXT,
            userpassword TEXT,
            address TEXT,
            isaddressprvided INTEGER,
            isrestaurentowner INTEGER,
            restaurantid INTEGER,
            last_visited_screen TEXT
          )
        ''');
      },
    );
    return _database!;
  }

  // Insert or update user data
  Future<void> insertOrUpdateUser(Map<String, dynamic> userData) async {
    final db = await database;
    await db.insert(
      'users',
      userData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get user by email
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'useremail = ?',
      whereArgs: [email],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Delete all users
  Future<void> deleteAllUsers() async {
    final db = await database;
    await db.delete('users');
  }
}
