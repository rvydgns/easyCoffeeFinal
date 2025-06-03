import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/button.dart';
import '../models/drink.dart';
import '../models/shop.dart';
import '../themes/colors.dart';
import 'package:provider/provider.dart';
import 'package:easycoffee_new/components/app_bar.dart';
import 'package:easycoffee_new/components/appdrawer.dart';

/// Belirli bir içeceğin detaylarını gösteren sayfa
class DrinkDetailsPage extends StatefulWidget {
  final Drink drink; // Gösterilecek içecek verisi

  const DrinkDetailsPage({super.key, required this.drink});

  @override
  State<DrinkDetailsPage> createState() => _DrinkDetailsPageState();
}

class _DrinkDetailsPageState extends State<DrinkDetailsPage> {
  int quantityCount = 0; // Kullanıcının seçeceği miktar

  /// Miktarı azaltan fonksiyon
  void decrementQuantity() {
    setState(() {
      if (quantityCount > 0) {
        quantityCount--;
      }
    });
  }

  /// Miktarı artıran fonksiyon
  void incrementQuantity() {
    setState(() {
      quantityCount++;
    });
  }

  /// Sepete içecek ekleme işlemi
  void addToCart() {
    if (quantityCount > 0) {
      final shop = context.read<Shop>();
      shop.addToCart(widget.drink, quantityCount); // Sepete içeceği ekle

      // Bilgilendirme dialogu göster
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          backgroundColor: primaryColor,
          content: const Text(
            "Sepete eklendi",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context); // Dialogu kapat
                Navigator.pushReplacementNamed(context, '/cartpage'); // Sepet sayfasına git
              },
              icon: const Icon(Icons.done, color: Colors.white),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Kahve Detayı'), // Özel uygulama başlığı
      drawer: const AppDrawer(), // Uygulama menüsü

      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ListView(
                children: [
                  // İçecek görseli
                  Image.asset(
                    widget.drink.imagePath,
                    height: 200,
                  ),
                  const SizedBox(height: 25),

                  // Puan
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow[800]),
                      const SizedBox(width: 5),
                      Text(
                        widget.drink.rating,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // İçecek adı
                  Text(
                    widget.drink.name,
                    style: GoogleFonts.dmSerifDisplay(fontSize: 28),
                  ),
                  const SizedBox(height: 25),

                  // Açıklama başlığı
                  Text(
                    "Açıklama",
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Açıklama metni
                  Text(
                    widget.drink.description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      height: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Alt bilgi alanı: fiyat, miktar seçimi, buton
          Container(
            color: primaryColor,
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                // Fiyat ve adet seçimi
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Fiyat
                    Text(
                      "₺${widget.drink.price}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    // Miktar seçim arayüzü
                    Row(
                      children: [
                        // Azalt butonu
                        Container(
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.remove, color: Colors.white),
                            onPressed: decrementQuantity,
                          ),
                        ),

                        // Seçilen miktar sayısı
                        SizedBox(
                          width: 40,
                          child: Center(
                            child: Text(
                              quantityCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),

                        // Artır butonu
                        Container(
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.add, color: Colors.white),
                            onPressed: incrementQuantity,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                // Sepete Ekle butonu
                MyButton(text: "Sepete Ekle", onTap: addToCart),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
