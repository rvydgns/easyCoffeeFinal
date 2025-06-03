import 'dart:async';
import 'package:easycoffee_new/components/button.dart';
import 'package:easycoffee_new/themes/colors.dart';
import 'package:flutter/material.dart';
import '../models/drink.dart';
import '../models/shop.dart';
import 'package:provider/provider.dart';
import 'package:easycoffee_new/components/app_bar.dart';
import 'package:easycoffee_new/components/appdrawer.dart';
import 'package:easycoffee_new/pages/checkout_page.dart';



class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void removeFromCart(Drink drink, BuildContext context) {
    final shop = context.read<Shop>();
    shop.removeFromCart(drink);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/menupage');
        return false;
      },
      child: Consumer<Shop>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: primaryColor,
          appBar: const CustomAppBar(title: "Sepetim"), // ✅ Custom AppBar
          drawer: const AppDrawer(), // ✅ Drawer eklendi
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: value.cart.length,
                  itemBuilder: (context, index) {
                    final Drink drink = value.cart[index];
                    final String drinkName = drink.name;
                    final String drinkPrice = drink.price;

                    return Container(
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: ListTile(
                        title: Text(
                          drinkName,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          drinkPrice,
                          style: TextStyle(
                            color: Colors.grey[200],
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.grey[300],
                          ),
                          onPressed: () => removeFromCart(drink, context),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: MyButton(
                  text: "Ödemeye geç",
                  onTap: () {
                    Navigator.pushNamed(context, '/checkout');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
