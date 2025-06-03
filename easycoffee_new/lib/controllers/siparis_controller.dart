import 'package:supabase_flutter/supabase_flutter.dart';

class SiparisController {
  final supabase = Supabase.instance.client;

  /// Supabase'e sipariş kaydeder ve eklenen veriyi geri döndürür
  Future<Map<String, dynamic>> siparisKaydet({
    required String isim,
    required String telefon,
    required String adres,
  }) async {
    try {
      final response = await supabase.from('siparis_ozetleri').insert({
        'isim': isim,
        'telefon': telefon,
        'adres': adres,
        'tarih': DateTime.now().toIso8601String(), // Sipariş zamanı
      }).select(); //  Eklenen satırı geri döndür

      return response[0]; //  İlk (ve tek) eklenen kayıt
    } catch (e) {
      throw Exception('Sipariş kaydedilemedi: $e');
    }
  }
}
