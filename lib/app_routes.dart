import 'package:flutter/material.dart';
import 'package:fluttergpt/screens/chat.dart';
import 'package:fluttergpt/screens/signup.dart';

class AppRoutes {
  static const String signup = '/signup';
  static const String chat = '/chat';

  static void navigateTo(BuildContext context, String routeName,
      {Object? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static void navigateAndReplace(BuildContext context, String routeName,
      {Object? arguments}) {
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }

  static void navigateAndClear(BuildContext context, String routeName,
      {Object? arguments}) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  static Map<String, WidgetBuilder> get routes => {
        signup: (context) => const SignupScreen(),
        chat: (context) => const ChatScreen(),
      };
}
