import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/auth_controller.dart';
import '../themes/colors.dart';

// Giriş sayfası
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Authentication controller nesnesi
  final _authController = AuthController();

  // E-posta ve şifre için TextEditingController'lar
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor, // Arka plan rengi
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: SingleChildScrollView( // Kaydırılabilir içerik
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),

              // Başlık
              Text(
                "Hoş geldiniz!",
                style: GoogleFonts.dmSerifDisplay(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),

              // Alt başlık
              const Text(
                "Lezzetli kahvelerimizle her anınıza sıcak bir dokunuş katın.",
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 30),

              // E-posta giriş alanı
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: secondaryColor,
                  hintText: "E-posta",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Şifre giriş alanı
              TextField(
                controller: _passwordController,
                obscureText: true, // Şifre gizlenir
                decoration: InputDecoration(
                  filled: true,
                  fillColor: secondaryColor,
                  hintText: "Şifre",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Şifremi unuttum linki
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Şifremi unuttum",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(height: 30),

              // Giriş yap butonu
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  // Giriş fonksiyonu çağrılır
                  onPressed: () {
                    _authController.loginWithEmail(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                      context: context,
                    );
                  },
                  child: const Text("Giriş Yap", style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 20),

              // Google ile giriş butonu
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.login),
                  label: const Text("Google ile Giriş"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  // Google giriş fonksiyonu
                  onPressed: () {
                    _authController.signInWithGoogle(context);
                  },
                ),
              ),
              const SizedBox(height: 15),

              // GitHub ile giriş butonu
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.code),
                  label: const Text("GitHub ile Giriş"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  // GitHub giriş fonksiyonu
                  onPressed: () {
                    _authController.signInWithGitHub(context);
                  },
                ),
              ),
              const SizedBox(height: 30),

              // Kayıt olma bağlantısı
              Center(
                child: TextButton(
                  onPressed: () {
                    // Kayıt sayfasına yönlendir
                    Navigator.pushReplacementNamed(context, '/registerpage');
                  },
                  child: const Text(
                    "Hesabınız yok mu? Kayıt olun",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
