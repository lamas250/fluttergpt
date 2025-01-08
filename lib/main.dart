import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttergpt/services/firebase_helper.dart';
import 'firebase_options.dart';
import 'app_routes.dart';

late final Widget screen;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  screen = FirebaseHelper.authenticatedScreen;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: screen,
      routes: AppRoutes.routes,
    );
  }
}
