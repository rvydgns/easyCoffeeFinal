import 'package:flutter/material.dart';
import '../components/button.dart';
import '../themes/colors.dart';
import 'order_summary_page.dart';
import '../controllers/siparis_controller.dart';

class CheckoutPage extends StatelessWidget {
  CheckoutPage({super.key});

  // Teslimat bilgileri için text controller'lar
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ödeme'),
        backgroundColor: primaryColor,
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Teslimat bilgileri başlığı
            const Text(
              "Teslimat Bilgileri",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Kullanıcı adı soyadı giriş alanı
            _buildField(hint: "Ad Soyad", controller: nameController),
            const SizedBox(height: 10),

            // Telefon numarası giriş alanı
            _buildPhoneField(hint: "Telefon Numarası", controller: phoneController),
            const SizedBox(height: 10),

            // Teslimat adresi giriş alanı
            _buildAddressField(hint: "Teslimat Adresi", maxLines: 3, controller: addressController),

            const SizedBox(height: 30),
            const Divider(thickness: 1),
            const SizedBox(height: 10),

            // Kart bilgileri başlığı
            const Text(
              "Kart Bilgileri",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Kart bilgileri kutusu
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kart üzerindeki isim
                  const Text("Kart Üzerindeki İsim", style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 5),
                  _buildStyledCardField(hint: "Ad Soyad"),
                  const SizedBox(height: 10),

                  // Kart numarası
                  const Text("Kart Numarası", style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 5),
                  _buildStyledCardField(hint: "XXXX XXXX XXXX XXXX"),
                  const SizedBox(height: 10),

                  // Son kullanma tarihi ve CVV yan yana
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("AA/YY", style: TextStyle(color: Colors.white)),
                            const SizedBox(height: 5),
                            _buildStyledCardField(hint: "12/24"),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("CVV", style: TextStyle(color: Colors.white)),
                            const SizedBox(height: 5),
                            _buildStyledCardField(hint: "123"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Siparişi onayla butonu
            MyButton(
              text: "Siparişi Onayla",
              onTap: () async {
                final siparisController = SiparisController();

                try {
                  // Sipariş kaydını yap
                  final siparis = await siparisController.siparisKaydet(
                    isim: nameController.text,
                    telefon: phoneController.text,
                    adres: addressController.text,
                  );

                  // Sipariş özet sayfasına geçiş
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderSummaryPage(
                        name: siparis['isim'],
                        phone: siparis['telefon'],
                        address: siparis['adres'],
                      ),
                    ),
                  );
                } catch (e) {
                  // Hata durumunda kullanıcıya bilgi ver
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Sipariş kaydedilemedi: $e")),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Genel metin giriş alanı
  Widget _buildField({required String hint, int maxLines = 1, TextEditingController? controller}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Telefon numarası giriş alanı (ikonlu)
  Widget _buildPhoneField({required String hint, TextEditingController? controller}) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        prefixIcon: Icon(Icons.phone, color: primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Adres giriş alanı (ikonlu)
  Widget _buildAddressField({required String hint, int maxLines = 3, TextEditingController? controller}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: TextInputType.streetAddress,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        prefixIcon: Icon(Icons.location_on, color: primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Kart bilgileri için özel stilli giriş alanı
  Widget _buildStyledCardField({required String hint}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
