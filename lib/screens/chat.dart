import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttergpt/models/user.dart';
import 'package:fluttergpt/services/firebase_helper.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Center(
          child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseHelper.buildViews,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          final List<UserModel> users = [];
          final List<QueryDocumentSnapshot>? docs = snapshot.data?.docs;
          if (docs == null || docs.isEmpty) {
            return const Text('No data');
          }
          for (var doc in docs) {
            users.add(UserModel.fromJson(doc.data() as Map<String, dynamic>));
          }
          return ListView.builder(
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(users[index].name),
            ),
            itemCount: users.length,
          );
        },
      )),
    );
  }
}
