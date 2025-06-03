import 'package:flutter/material.dart';
import '../controllers/local_db_controller.dart';
import '../models/user_model.dart';

/// SQLite veritabanındaki kullanıcı verilerini test etmek için kullanılan sayfa.
class DebugSQLitePage extends StatefulWidget {
  const DebugSQLitePage({super.key});

  @override
  State<DebugSQLitePage> createState() => _DebugSQLitePageState();
}

class _DebugSQLitePageState extends State<DebugSQLitePage> {
  // Kullanıcı verisi alındığında ekranda gösterilecek olan mesaj
  String _log = "Bekleniyor...";

  @override
  void initState() {
    super.initState();
    // Sayfa yüklendiğinde SQLite'dan kullanıcı verisini çek
    _fetchUserFromSQLite();
  }

  /// SQLite veritabanından kullanıcıyı çekip ekranda gösteren metod
  Future<void> _fetchUserFromSQLite() async {
    final user = await LocalDatabase.getUser();

    if (user != null) {
      // Konsola kullanıcı bilgilerini yazdır
      print("SQLite'dan okunan kullanıcı: ${user.uid}, ${user.email}");

      // Ekranda gösterilecek mesajı güncelle
      setState(() {
        _log = "Kullanıcı bulundu:\nUID: ${user.uid}\nEmail: ${user.email}";
      });
    } else {
      // Konsola kullanıcı bulunamadı mesajı yazdır
      print("SQLite'da kullanıcı bulunamadı.");

      // Ekranda gösterilecek mesajı güncelle
      setState(() {
        _log = "SQLite'da kullanıcı bulunamadı.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SQLite Test")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          // Kullanıcı verisi veya hata mesajını ekranda göster
          child: Text(
            _log,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
