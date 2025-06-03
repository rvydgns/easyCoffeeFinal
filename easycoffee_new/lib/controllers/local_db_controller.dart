import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../models/user_model.dart';

class LocalDatabase {
  static Database? _db;

  /// Veritabanı örneğini al
  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  /// Veritabanını başlat
  static Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "user.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  /// Veritabanında tabloyu oluştur
  static Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        uid TEXT PRIMARY KEY,
        email TEXT
      )
    ''');
    print("🟢 SQLite: 'users' tablosu oluşturuldu.");
  }

  /// Kullanıcıyı veritabanına ekle
  static Future<void> insertUser(LocalUser user) async {
    try {
      final db = await database;
      await db.insert('users', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      print("✅ SQLite: Kullanıcı eklendi -> UID: ${user.uid}, Email: ${user.email}");
    } catch (e) {
      print("❌ SQLite insertUser HATA: $e");
    }
  }

  /// Kullanıcıyı veritabanından oku
  static Future<LocalUser?> getUser() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('users');

      if (maps.isNotEmpty) {
        final user = LocalUser.fromMap(maps.first);
        print("🟢 SQLite: Kullanıcı bulundu -> UID: ${user.uid}, Email: ${user.email}");
        return user;
      } else {
        print("🔴 SQLite: Kullanıcı bulunamadı.");
      }
    } catch (e) {
      print("❌ SQLite getUser HATA: $e");
    }
    return null;
  }

  /// Kullanıcı verilerini sil
  static Future<void> clearUsers() async {
    try {
      final db = await database;
      await db.delete('users');
      print("🧹 SQLite: Tüm kullanıcılar silindi.");
    } catch (e) {
      print("❌ SQLite clearUsers HATA: $e");
    }
  }
}
