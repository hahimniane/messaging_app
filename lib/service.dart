import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //giriş yap fonksiyonu
  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Hosgeldin";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Bulunamadı';
      } else if (e.code == 'wrong-password') {
        return 'Şifre Yanlış';
      }

      return 'Hataaa';
    } catch (e) {
      return 'Hataaa: ' + e.toString();
    }
  }

  //çıkış yap fonksiyonu
  signOut() async {
    return await _auth.signOut();
  }

  //kayıt ol fonksiyonu
  Future<String> createPerson(
      { //required String name,
      required String email,
      required String password}) async {
    try {
      //DocumentReference documentReference=_firestore.doc(_auth.currentUser.uid);
      var user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // await _firestore
      //     .collection("Kullanıcılar")
      //     .doc(user.user!.uid)
      //     .set({'isim': name, 'email': email});
      return "Olusturuldu";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return 'Sifre kotu';
      } else if (e.code == 'email-already-in-use') {
        return 'bu hesap var ';
      }
    } catch (e) {
      return "Hatalı Giris: " + e.toString();
    }
    return 'Hatalı giris';
  }

  Future<String> resetPass({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return 'Email Gonderildi';
    } catch (e) {
      return 'Hatali Giris';
    }
  }

  Stream<QuerySnapshot> getStatus() {
    var ref = _firestore.collection("messages").snapshots();
    return ref;
  }

  void messagesStream() async {
    await for (var snapShot in _firestore.collection('messages').snapshots()) {
      for (var message in snapShot.docs) {
        print(message.data());
      }
    }
  }
}
