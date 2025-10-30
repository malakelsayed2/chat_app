import 'package:chat_app/views/chat_screen.dart';
import 'package:chat_app/views/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../views/home_screen.dart';
import '../views/sign_in_screen.dart';
import '../views/verification_screen.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFFF7F8FA)),
      home: FirebaseAuth.instance.currentUser != null
          ? FirebaseAuth.instance.currentUser!.emailVerified
                ? HomeScreen()
                : SignInScreen()
          : SignUpScreen(),
    );
  }
}
