// // Import pustaka sqflite untuk interaksi dengan SQLite database
// import 'package:sqflite/sqflite.dart' as sql;
// import 'package:path/path.dart';

// // Import file definisi kelas Shoe dari model
// import 'models/shoe.dart';

// class DatabaseHelper {
//   static Future<sql.Database> db() async {
//     try {
//       return sql.openDatabase(
//         join(await sql.getDatabasesPath(), 'sneaker_shop.db'),
//         version: 1,
//         onCreate: (database, version) async {
//           await database.execute("""
//           CREATE TABLE shoes(
//             id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
//             name TEXT,
//             price TEXT,
//             description TEXT,
//             imagePath TEXT
//           )
//           """);
//         },
//       );
//     } catch (e) {
//       print("Error opening database: $e");
//       throw e;
//     }
//   }

//   static Future<int> addShoe(Shoe shoe) async {
//     final db = await DatabaseHelper.db();
//     final data = shoe.toMap();
//     return db.insert('shoes', data);
//   }

//   static Future<List<Map<String, dynamic>>> getShoes() async {
//     final db = await DatabaseHelper.db();
//     return db.query("shoes");
//   }
// }


import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLHelper {
  static Database? _database;
  static const String tableName = 'shoes';

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'shoes_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            price TEXT,
            description TEXT,
            imagepath TEXT
          )
        ''');
      },
    );
  }

  static Future<void> tambahCatatan3(
      String title, String price, String description, String imagepath) async {
    final db = await database;

    await db.insert(
      tableName,
      {
        'title': title,
        'price': price,
        'description': description,
        'imagepath': imagepath,
      },
    );
  }

  static Future<List<Map<String, dynamic>>> getCatatan3() async {
    final db = await database;
    return await db.query(tableName);
  }

  static Future<void> hapusCatatan3(int id) async {
    final db = await database;
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> ubahCatatan3(int id, String title, String price, String description, String imagepath) async {
    final db = await database;

    await db.update(
      tableName,
      {
        'title': title,
        'price': price,
        'description': description,
        'imagepath': imagepath,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
