import 'package:easycoffee_new/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'firebase_options.dart'; // flutterfire configure ile oluşturulmuş dosya
import 'models/shop.dart';

// Sayfalar
import 'pages/cart_page.dart';
import 'pages/intro_page.dart';
import 'pages/menu_page.dart';
import 'pages/login_page.dart';
import 'pages/checkout_page.dart';
import 'pages/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase başlatılıyor
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Supabase başlatılıyor
  await Supabase.initialize(
    url: 'https://bzkqxqwxvmquxoyqzmud.supabase.co',         // <-- kendi Supabase URL’in
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ6a3F4cXd4dm1xdXhveXF6bXVkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDg5MDM4MjgsImV4cCI6MjA2NDQ3OTgyOH0.NFtOqN6rTTLoY625yCEP05n_FRMuqM23wAFtVFZgQBk',                        // <-- kendi Supabase anonKey’in
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => Shop(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/intropage',
      routes: {
        '/intropage': (context) => const IntroPage(),
        '/loginpage': (context) => const LoginPage(),
        '/menupage': (context) => const MenuPage(),
        '/cartpage': (context) => const CartPage(),
        '/registerpage': (context) => const RegisterPage(),
        '/checkout': (context) =>  CheckoutPage(),
        '/profilepage': (context) => const ProfilePage(),
      },
    );
  }
}
