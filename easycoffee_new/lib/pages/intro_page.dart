import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/button.dart';
import '../components/drink_tile.dart';
import '../models/drink.dart';
import '../themes/colors.dart';
import 'drink_details_page.dart';


class IntroPage extends StatelessWidget {
  const IntroPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 25),
            // Shop name
            const Text(
              "Easy Coffee",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(height: 25),


            //icon
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Image.asset('lib/images/expresso.png'),
            ),


            const SizedBox(height: 25),
            //title
            Text(
              "Lezzetli kahvenin tadı... 1974'den beri",
              style: TextStyle(fontSize: 34, color: Colors.white),
            ),


            const SizedBox(height: 10),
            // subtitle
            Text(
              "En taze çekirdeklerle hazırlanan özel kahvelerimizle, her yudumda sıcak bir hikaye sunuyoruz.",
              style: TextStyle(color: Colors.grey, height: 2,fontSize: 18),
            ),


            const SizedBox(height: 25),


            MyButton(
              text: "Göz at",
              onTap: () {
                Navigator.pushNamed(context, '/loginpage');
              },
            )
          ],
        ),
      ),
    );
  }
}
