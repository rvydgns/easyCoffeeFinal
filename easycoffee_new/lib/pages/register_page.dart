import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../themes/colors.dart';

// Kayıt olma sayfasını tanımlayan StatefulWidget
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // E-posta ve şifre için text controller'lar
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Giriş/kayıt işlemleri için AuthController nesnesi
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor, // Arka plan rengi
      appBar: AppBar(
        title: const Text("Kayıt Ol"), // Başlık
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20), // Sayfanın kenar boşlukları
        child: Column(
          children: [
            // E-posta girişi için TextField
            TextField(
              controller: _emailController, // Controller ile kullanıcıdan e-posta alınır
              decoration: InputDecoration(
                hintText: "E-posta",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),

            // Şifre girişi için TextField
            TextField(
              controller: _passwordController, // Controller ile kullanıcıdan şifre alınır
              obscureText: true, // Şifre gizlenir
              decoration: InputDecoration(
                hintText: "Şifre",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),

            // Kayıt olma işlemini başlatan buton
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  // E-posta ve şifre ile kayıt ol
                  _authController.registerWithEmail(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                    context: context,
                  );
                },
                child: const Text("Kayıt Ol", style: TextStyle(fontSize: 16)),
              ),
            ),

            const SizedBox(height: 20),

            // Google ile kayıt ol butonu
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.mail_outline), // İkon
                label: const Text("Google ile Kayıt Ol"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  // Google ile kayıt ol
                  _authController.signInWithGoogle(context);
                },
              ),
            ),

            const SizedBox(height: 12),

            // GitHub ile kayıt ol butonu
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.code), // İkon
                label: const Text("GitHub ile Kayıt Ol"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  // GitHub ile kayıt ol
                  _authController.signInWithGitHub(context);
                },
              ),
            ),

            const SizedBox(height: 20),

            // Kullanıcının zaten hesabı varsa login sayfasına yönlendirme
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/loginpage");
              },
              child: const Text(
                "Zaten hesabınız var mı? Giriş yap",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
