import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AuthHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'user.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, email TEXT, password TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<bool> register(String email, String password) async {
    final db = await database;
    await db.insert(
      'users',
      {'email': email, 'password': password},
    );
    return true;
  }

  static Future<bool> login(String email, String password) async {
    final db = await database;
    var user = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return user.isNotEmpty;
  }
}
