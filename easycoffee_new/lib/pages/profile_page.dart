import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/shared_pref_controller.dart';
import '../themes/colors.dart';
import '../components/appdrawer.dart';
import '../controllers/supabase_profile_controller.dart';
import 'package:easycoffee_new/pages/base_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Kullanıcı bilgilerinin tutulduğu controllerlar
  final TextEditingController _adController = TextEditingController();
  final TextEditingController _soyadController = TextEditingController();
  final TextEditingController _telefonController = TextEditingController();
  final TextEditingController _adresMahalleController = TextEditingController();
  final TextEditingController _adresIlceController = TextEditingController();
  final TextEditingController _adresIlController = TextEditingController();
  final TextEditingController _dogumTarihiController = TextEditingController();
  final TextEditingController _dogumYeriController = TextEditingController();

  // Cinsiyet seçimi için değişken
  String? selectedGender;

  // Supabase'den profil bilgilerini almak ve kaydetmek için controller
  final SupabaseProfileController _controller = SupabaseProfileController();

  @override
  void initState() {
    super.initState();
    _loadProfileData(); // Sayfa ilk yüklendiğinde kullanıcı bilgilerini getir
  }

  // Kullanıcının profil bilgilerini Supabase ve Firestore'dan alır
  Future<void> _loadProfileData() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userEmail = FirebaseAuth.instance.currentUser!.email ?? '';

    final data = await _controller.getUserProfile(userId);
    final firestore = FirebaseFirestore.instance;
    final firebaseData = await firestore
        .collection('kullanici_ozel_bilgileri')
        .doc(userId)
        .get();

    if (data != null || firebaseData.exists) {
      final ad = data?['ad'] ?? '';
      final soyad = data?['soyad'] ?? '';

      // SharedPreferences'e kullanıcı bilgisini kaydet
      await SharedPrefService.saveUserInfo(
        uid: userId,
        email: userEmail,
        ad: ad,
        soyad: soyad,
      );

      setState(() {
        // Ekrana getirilecek verileri controller'lara ata
        _adController.text = ad;
        _soyadController.text = soyad;
        _telefonController.text = data?['telefon'] ?? '';

        // Adresi virgül ile ayrılmış şekilde parçala
        final adres = (data?['adres'] ?? '').split(', ');
        _adresMahalleController.text = adres.isNotEmpty ? adres[0] : '';
        _adresIlceController.text = adres.length > 1 ? adres[1] : '';
        _adresIlController.text = adres.length > 2 ? adres[2] : '';

        selectedGender = data?['cinsiyet'];
        _dogumTarihiController.text = firebaseData['dogum_tarihi'] ?? '';
        _dogumYeriController.text = firebaseData['dogum_yeri'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Profilim",
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label("Ad"),
            _buildField(controller: _adController, hint: "Ad"),
            _label("Soyad"),
            _buildField(controller: _soyadController, hint: "Soyad"),
            _label("Telefon Numarası"),
            _buildPhoneField(controller: _telefonController, hint: "5XX XXX XX XX"),
            _label("Adres Bilgileri"),
            _buildAddressField(controller: _adresMahalleController, hint: "Mahalle/Sokak", icon: Icons.home),
            const SizedBox(height: 10),
            _buildAddressField(controller: _adresIlceController, hint: "İlçe", icon: Icons.location_city),
            const SizedBox(height: 10),
            _buildAddressField(controller: _adresIlController, hint: "İl", icon: Icons.map),
            _label("Cinsiyet"),
            Row(
              children: [
                _genderButton("Erkek", Icons.male),
                const SizedBox(width: 10),
                _genderButton("Kadın", Icons.female),
              ],
            ),
            _label("Doğum Tarihi"),
            _buildField(controller: _dogumTarihiController, hint: "GG/AA/YYYY"),
            _label("Doğum Yeri"),
            _buildField(controller: _dogumYeriController, hint: "Şehir"),
            const SizedBox(height: 25),
            _saveButton(), // Kaydet butonu
          ],
        ),
      ),
    );
  }

  // Form etiketlerini gösterir
  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(top: 15, bottom: 5),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
  );

  // Cinsiyet seçim butonu
  Widget _genderButton(String gender, IconData icon) => Expanded(
    child: ElevatedButton.icon(
      onPressed: () => setState(() => selectedGender = gender),
      icon: Icon(icon),
      label: Text(gender),
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedGender == gender ? primaryColor : Colors.grey[300],
        foregroundColor: selectedGender == gender ? Colors.white : Colors.black,
      ),
    ),
  );

  // Kullanıcının bilgilerini Supabase ve Firestore'a kaydeder
  Widget _saveButton() => SizedBox(
    width: double.infinity,
    height: 50,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () async {
        final userId = FirebaseAuth.instance.currentUser!.uid;
        final email = FirebaseAuth.instance.currentUser!.email ?? '';
        try {
          // Supabase'e kaydet
          await _controller.saveProfile(
            id: userId,
            ad: _adController.text.trim(),
            soyad: _soyadController.text.trim(),
            telefon: _telefonController.text.trim(),
            adres:
            "${_adresMahalleController.text.trim()}, ${_adresIlceController.text.trim()}, ${_adresIlController.text.trim()}",
            cinsiyet: selectedGender ?? '',
            dogumYeri: _dogumYeriController.text.trim(),
            dogumTarihi: _dogumTarihiController.text.trim(),
            yasadigiIl: _adresIlController.text.trim(),
          );

          // Firestore'a kaydet
          await FirebaseFirestore.instance
              .collection('kullanici_ozel_bilgileri')
              .doc(userId)
              .set({
            'dogum_tarihi': _dogumTarihiController.text.trim(),
            'dogum_yeri': _dogumYeriController.text.trim(),
            'yasadigi_il': _adresIlController.text.trim(),
          });

          // SharedPreferences güncelle
          await SharedPrefService.saveUserInfo(
            uid: userId,
            email: email,
            ad: _adController.text.trim(),
            soyad: _soyadController.text.trim(),
          );

          // Başarı mesajı göster
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Profil bilgileri kaydedildi.")),
          );
        } catch (e) {
          // Hata mesajı göster
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Hata: $e")),
          );
        }
      },
      child: const Text("Kaydet", style: TextStyle(fontSize: 16, color: Colors.white)),
    ),
  );

  // Basit metin alanı bileşeni
  Widget _buildField({required TextEditingController controller, required String hint}) => TextField(
    controller: controller,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    ),
  );

  // Telefon numarası için özel alan
  Widget _buildPhoneField({required TextEditingController controller, required String hint}) => TextField(
    controller: controller,
    keyboardType: TextInputType.phone,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hint,
      prefixIcon: const Icon(Icons.phone),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    ),
  );

  // Adres bilgileri için özel alan
  Widget _buildAddressField(
      {required TextEditingController controller, required String hint, required IconData icon}) =>
      TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        ),
      );
}
