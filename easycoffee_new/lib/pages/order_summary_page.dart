import 'package:flutter/material.dart';
import '../themes/colors.dart';
import '../controllers/siparis_controller.dart';
import '../components/appdrawer.dart'; // 🔹 Drawer için import

class OrderSummaryPage extends StatelessWidget {
  final String name;
  final String phone;
  final String address;

  const OrderSummaryPage({
    super.key,
    required this.name,
    required this.phone,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    final _siparisController = SiparisController();

    // Siparişi Supabase'e kaydet
    _siparisController.siparisKaydet(
      isim: name,
      telefon: phone,
      adres: address,
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Sipariş Tamamlandı'),
        backgroundColor: primaryColor,
      ),
      drawer: const AppDrawer(), // 🔹 Drawer eklendi
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Icon(Icons.check_circle_outline, size: 80, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              "Siparişiniz başarıyla alındı!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Sipariş Özeti',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            _buildInfoTile(label: "İsim Soyisim", value: name),
            _buildInfoTile(label: "Telefon", value: phone),
            _buildInfoTile(label: "Adres", value: address),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/menupage'));
                },
                child: const Text(
                  "Ana Sayfaya Dön",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile({required String label, required String value}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
