import 'dart:convert';
import 'package:easycoffee_new/controllers/shared_pref_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import 'local_db_controller.dart';

class AuthController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // 🔹 E-posta & Şifre ile Giriş
  void loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        //  SharedPreferences'e yaz
        await SharedPrefService.saveUserInfo(
          uid: currentUser.uid,
          email: currentUser.email ?? '',
          ad: 'Ad', // Supabase'den çekiliyorsa sonra güncellenebilir
          soyad: 'Soyad',
        );

        // SQLite'e yaz
        await LocalDatabase.insertUser(LocalUser(
          uid: currentUser.uid,
          email: currentUser.email ?? '',
        ));
      }

      Navigator.pushReplacementNamed(context, '/menupage');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Giriş başarılı!")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Hata: $e")));
    }
  }

  // 🔹 E-posta & Şifre ile Kayıt
  void registerWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        //  SharedPreferences'e yaz
        await SharedPrefService.saveUserInfo(
          uid: currentUser.uid,
          email: currentUser.email ?? '',
          ad: 'Ad', // Profil sonrası güncellenir
          soyad: 'Soyad',
        );

        //  SQLite'e yaz
        await LocalDatabase.insertUser(LocalUser(
          uid: currentUser.uid,
          email: currentUser.email ?? '',
        ));
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Kayıt başarılı!")));
      Navigator.pushReplacementNamed(context, "/loginpage");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Hata: $e")));
    }
  }

  // 🔹 Google ile Giriş
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);

      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        await SharedPrefService.saveUserInfo(
          uid: currentUser.uid,
          email: currentUser.email ?? '',
          ad: 'Ad', // isteğe göre güncellenebilir
          soyad: 'Soyad',
        );

        await LocalDatabase.insertUser(LocalUser(
          uid: currentUser.uid,
          email: currentUser.email ?? '',
        ));
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Google ile giriş başarılı")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Hata: $e")));
    }
  }

  // 🔹 GitHub ile Giriş
  Future<void> signInWithGitHub(BuildContext context) async {
    try {
      final clientId = "GITHUB_CLIENT_ID";
      final clientSecret = "GITHUB_CLIENT_SECRET";
      final redirectUri = "https://<project-id>.firebaseapp.com/__/auth/handler";

      final result = await FlutterWebAuth.authenticate(
        url:
        "https://github.com/login/oauth/authorize?client_id=$clientId&redirect_uri=$redirectUri&scope=read:user%20user:email",
        callbackUrlScheme: "https",
      );

      final code = Uri.parse(result).queryParameters['code'];

      final tokenResponse = await http.post(
        Uri.parse("https://github.com/login/oauth/access_token"),
        headers: {"Accept": "application/json"},
        body: {
          "client_id": clientId,
          "client_secret": clientSecret,
          "code": code!,
        },
      );

      final accessToken = json.decode(tokenResponse.body)['access_token'];
      final AuthCredential githubAuthCredential = GithubAuthProvider.credential(accessToken);

      await _firebaseAuth.signInWithCredential(githubAuthCredential);

      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        await SharedPrefService.saveUserInfo(
          uid: currentUser.uid,
          email: currentUser.email ?? '',
          ad: 'Ad',
          soyad: 'Soyad',
        );

        await LocalDatabase.insertUser(LocalUser(
          uid: currentUser.uid,
          email: currentUser.email ?? '',
        ));
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("GitHub ile giriş başarılı")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Hata: $e")));
    }
  }

  // 🔹 Çıkış İşlemi
  Future<void> signOut(BuildContext context) async {
    await _firebaseAuth.signOut();
    await SharedPrefService.clearUserInfo();
    Navigator.pushReplacementNamed(context, "/loginpage");
  }
}
