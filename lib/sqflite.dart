// Import pustaka sqflite untuk interaksi dengan SQLite database
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';

// Import file definisi kelas Foto dari model
class Foto {
  int id;
  String judul;
  int harga;
  String deskripsi;
  String ukuran;
  String imagePath;

  Foto({
    required this.id,
    required this.judul,
    required this.harga,
    required this.deskripsi,
    required this.ukuran,
    required this.imagePath,
  });

  // Factory constructor to create a Foto instance from a map
  factory Foto.fromMap(Map<String, dynamic> map) {
    return Foto(
      id: map['id'],
      judul: map['judul'],
      harga: map['harga'],
      deskripsi: map['deskripsi'],
      ukuran: map['ukuran'],
      imagePath: map['imagePath'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'judul': judul,
      'harga': harga,
      'deskripsi': deskripsi,
      'ukuran': ukuran,
      'imagePath': imagePath,
    };
  }
}

class DatabaseHelper {
  static Future<sql.Database> db() async {
    try {
      return sql.openDatabase(
        join(await sql.getDatabasesPath(), 'sneaker_shop.db'),
        version: 1,
        onCreate: (database, version) async {
          await database.execute("""
          CREATE TABLE foto(
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            judul TEXT,
            harga INTEGER,
            deskripsi TEXT,
            ukuran TEXT,
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

  static Future<int> tambahFoto(Foto foto) async {
    final db = await DatabaseHelper.db();
    final data = foto.toMap();
    return db.insert('foto', data);
  }

  static Future<List<Foto>> getFoto() async {
    final db = await DatabaseHelper.db();
    final List<Map<String, dynamic>> maps = await db.query("foto");
    return List.generate(maps.length, (i) {
      return Foto.fromMap(maps[i]);
    });
  }

  static Future<int> updateFoto(Foto foto) async {
    final db = await DatabaseHelper.db();
    final data = foto.toMap();
    return db.update('foto', data, where: "id=?", whereArgs: [foto.id]);
  }

  static Future<int> deleteFoto(int id) async {
    final db = await DatabaseHelper.db();
    return db.delete("foto", where: 'id = ?', whereArgs: [id]);
  }
}
