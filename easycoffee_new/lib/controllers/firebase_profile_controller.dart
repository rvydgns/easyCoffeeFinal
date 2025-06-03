import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseProfileController {
  Future<void> saveBasicInfo({
    required String dogumYeri,
    required String dogumTarihi,
    required String yasadigiIl,
  }) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid != null) {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'dogumYeri': dogumYeri,
        'dogumTarihi': dogumTarihi,
        'yasadigiIl': yasadigiIl,
      }, SetOptions(merge: true));
    }
  }
}
