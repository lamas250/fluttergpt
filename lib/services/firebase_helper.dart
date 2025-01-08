import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttergpt/models/user.dart';
import 'package:fluttergpt/screens/chat.dart';
import 'package:fluttergpt/screens/signin.dart';
import 'package:cloud_functions/cloud_functions.dart';

class FirebaseHelper {
  const FirebaseHelper._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<bool> signUp(
    String email,
    String password,
    String name,
  ) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user?.updateDisplayName(name);

      if (userCredential.user == null) {
        return false;
      }

      var userRef =
          _firestore.collection('users').doc(userCredential.user!.uid);

      final now = DateTime.now();
      final String createdAt = now.toIso8601String();
      final String token = '';

      final userModel = UserModel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        platform: Platform.operatingSystem,
        token: token,
        createdAt: createdAt,
      );

      await userRef.set(userModel.toJson());

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> signIn(
    String email,
    String password,
  ) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> get buildViews =>
      _firestore.collection('users').snapshots();

  static Widget get authenticatedScreen {
    if (_auth.currentUser == null) {
      return const SigninScreen();
    }
    return const ChatScreen();
  }

  static Future<void> testHealth() async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('checkHealth');
    final result = await callable.call();
    print(result.data);
  }

  static Future<String> chatWithOpenAI(String data) async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('chatWithOpenAI');
    final prompt = {
      'prompt': data,
    };
    final result = await callable.call(prompt);

    return result.data;
  }
}
