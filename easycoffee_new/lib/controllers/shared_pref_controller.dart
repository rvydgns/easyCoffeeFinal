import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  // 🔹 Kullanıcı bilgilerini kaydet
  static Future<void> saveUserInfo({
    required String uid,
    required String email,
    required String ad,
    required String soyad,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', uid);
    await prefs.setString('email', email);
    await prefs.setString('ad', ad);
    await prefs.setString('soyad', soyad);
  }

  // 🔹 Kullanıcı bilgilerini getir
  static Future<Map<String, String?>> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'uid': prefs.getString('uid'),
      'email': prefs.getString('email'),
      'ad': prefs.getString('ad'),
      'soyad': prefs.getString('soyad'),
    };
  }

  // 🔹 Bilgileri sil (örn. çıkışta)
  static Future<void> clearUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
