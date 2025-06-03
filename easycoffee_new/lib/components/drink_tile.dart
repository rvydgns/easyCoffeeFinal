import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/button.dart';
import '../components/drink_tile.dart';
import '../models/drink.dart';
import '../themes/colors.dart';


class DrinkTile extends StatelessWidget {
  final Drink drink;
  final void Function()? onTap;
  const DrinkTile({
    super.key,
    required this.drink,
    required this.onTap,
  });




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.only(left: 25),
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              drink.imagePath,
              height: 140,
            ),


            Text(
              drink.name,
              style: GoogleFonts.dmSerifDisplay(fontSize: 20),
            ),


            SizedBox(
              width: 160,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\₺' + drink.price, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)
                  ),


                  Row(
                    children: [
                      Icon(
                          Icons.star,
                          color: Colors.yellow
                      ),
                      Text(
                        drink.rating,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
