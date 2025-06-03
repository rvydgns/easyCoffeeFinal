import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/button.dart';
import '../components/drink_tile.dart';
import '../models/drink.dart';
import '../models/shop.dart';
import '../themes/colors.dart';
import 'drink_details_page.dart';
import 'package:provider/provider.dart';
import '../components/appdrawer.dart';
import 'package:easycoffee_new/components/app_bar.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  void navigateToDrinkDetails(int index) {
    final shop = context.read<Shop>();
    final drinkMenu = shop.drinkMenu;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DrinkDetailsPage(
          drink: drinkMenu[index],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final shop = context.read<Shop>();
    final drinkMenu = shop.drinkMenu;

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: const CustomAppBar(title: 'Menü'), // ✅ Burada kullanıldı
      drawer: const AppDrawer(), // ✅ Drawer da burada
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reklam / Kampanya Kutusu
          Container(
            decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.symmetric(horizontal: 25),
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "%32 indirim kazanın!",
                      style: GoogleFonts.dmSerifDisplay(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    MyButton(
                      text: "Devamı için",
                      onTap: () {},
                    ),
                  ],
                ),
                Image.asset('lib/images/ice latte.png', height: 100),
              ],
            ),
          ),
          const SizedBox(height: 25),

          // Arama Çubuğu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "Arama...",
              ),
            ),
          ),
          const SizedBox(height: 25),

          // Başlık
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Kahve Menüsü",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Ürün Listesi
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: drinkMenu.length,
              itemBuilder: (context, index) => DrinkTile(
                drink: drinkMenu[index],
                onTap: () => navigateToDrinkDetails(index),
              ),
            ),
          ),
          const SizedBox(height: 25),

          // Öne Çıkan Ürün Kartı
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'lib/images/hot-coffee.png',
                      height: 60,
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Filtre Kahve",
                          style: GoogleFonts.dmSerifDisplay(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        const Text('₺150.00', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                const Icon(Icons.favorite_outline, color: Colors.grey, size: 28),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
