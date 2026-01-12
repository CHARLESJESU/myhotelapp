import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _database;

  // Singleton pattern
  static DatabaseService? _instance;
  static DatabaseService get instance => _instance ??= DatabaseService._();
  DatabaseService._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    return await openDatabase(
      path,
      version: 2, // Updated version to trigger onUpgrade
      onCreate: _createTables,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add the last_visited_screen column for existing databases
      try {
        await db.execute('ALTER TABLE users ADD COLUMN last_visited_screen TEXT');
      } catch (e) {
        // Column might already exist, ignore the error
      }
    }
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        userid INTEGER PRIMARY KEY,
        username TEXT NOT NULL,
        useremail TEXT UNIQUE NOT NULL,
        phoneNumber TEXT,
        userpassword TEXT,
        address TEXT,
        isaddressprvided INTEGER,
        isrestaurentowner INTEGER,
        last_visited_screen TEXT
      )
    ''');
  }

  // Insert or update user data
  Future<int> insertOrUpdateUser(Map<String, dynamic> userData) async {
    final db = await database;
    
    // Check if user already exists
    final existingUser = await db.query(
      'users',
      where: 'userid = ?',
      whereArgs: [userData['userid']],
    );

    if (existingUser.isNotEmpty) {
      // Update existing user
      return await db.update(
        'users',
        userData,
        where: 'userid = ?',
        whereArgs: [userData['userid']],
      );
    } else {
      // Insert new user
      return await db.insert('users', userData);
    }
  }

  // Get user by ID
  Future<Map<String, dynamic>?> getUserById(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'userid = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  // Get user by email
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'useremail = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  // Get all users
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    return await db.query('users');
  }

  // Delete user
  Future<int> deleteUser(int userId) async {
    final db = await database;
    return await db.delete(
      'users',
      where: 'userid = ?',
      whereArgs: [userId],
    );
  }

  // Close database
  Future<void> close() async {
    final db = await database;
    db.close();
  }
}