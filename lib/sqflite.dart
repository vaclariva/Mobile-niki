// Import pustaka sqflite untuk interaksi dengan SQLite database
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';

// Import file definisi kelas Shoe dari model
import 'models/shoe.dart';

class DatabaseHelper {
  static Future<sql.Database> db() async {
    try {
      return sql.openDatabase(
        join(await sql.getDatabasesPath(), 'sneaker_shop.db'),
        version: 1,
        onCreate: (database, version) async {
          await database.execute("""
          CREATE TABLE shoes(
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            name TEXT,
            price TEXT,
            description TEXT,
            imagePath TEXT
          )
          """);
        },
      );
    } catch (e) {
      print("Error opening database: $e");
      throw e;
    }
  }

  static Future<int> addShoe(Shoe shoe) async {
    final db = await DatabaseHelper.db();
    final data = shoe.toMap();
    return db.insert('shoes', data);
  }

  static Future<List<Map<String, dynamic>>> getShoes() async {
    final db = await DatabaseHelper.db();
    return db.query("shoes");
  }
}
