import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart'as path;

class DatabaseHelper {
  // late Database db;
  static Database? _database;
  static const String tableName = 'users';

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
  
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, 'user_database.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE $tableName(id INTEGER PRIMARY KEY, username TEXT, email TEXT, password TEXT)');
      },
      version: 1,
    );
    return db;
  }

   Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert(tableName, user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

   Future<bool> authenticateUser(String enteredEmail, String enteredPassword) async {
  final db = await database;
  final List<Map<String, dynamic>> result = await db.query(
    tableName,
    where: 'email = ? AND password = ?',
    whereArgs: [enteredEmail, enteredPassword],
  );
  return result.isNotEmpty; 
}

}

class User {
  final String username;
  final String email;
  final String password;

  User({required this.username, required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}
