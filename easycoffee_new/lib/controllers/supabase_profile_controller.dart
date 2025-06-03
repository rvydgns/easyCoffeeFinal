import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseProfileController {
  final supabase = Supabase.instance.client;

  // Kullanıcı bilgilerini Supabase'den çek
  Future<Map<String, dynamic>?> getUserProfile(String id) async {
    try {
      final response = await supabase
          .from('kullanicilar')
          .select()
          .eq('id', id)
          .single();

      return response;
    } catch (e) {
      print('Kullanıcı profili çekilirken hata oluştu: $e');
      return null;
    }
  }

  // Kullanıcı bilgilerini Supabase'e kaydet
  Future<void> saveProfile({
    required String id,
    required String ad,
    required String soyad,
    required String telefon,
    required String adres,
    required String cinsiyet,
    required String dogumYeri,
    required String dogumTarihi,
    required String yasadigiIl,

  }) async {
    // Boş alan kontrolü
    if ([id, ad, soyad, telefon, adres, cinsiyet,dogumTarihi, dogumYeri,yasadigiIl].any((e) => e.isEmpty)) {
      throw Exception("Lütfen tüm alanları doldurunuz.");
    }

    try {
      await supabase.from('kullanicilar').upsert({
        'id': id,
        'ad': ad,
        'soyad': soyad,
        'telefon': telefon,
        'adres': adres,
        'cinsiyet': cinsiyet,
        'dogum_tarihi':dogumTarihi,
        'dogum_yeri': dogumYeri,
        'yasadigi_il': yasadigiIl,
      });
    } catch (e) {
      print('Profil kaydedilirken hata oluştu: $e');
      rethrow;
    }
  }
}
