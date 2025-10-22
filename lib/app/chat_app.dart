import 'package:chat_app/views/sign_up_screen.dart';
import 'package:flutter/material.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(
      scaffoldBackgroundColor: Color(0xFFF7F8FA),
    ), home: SignUpScreen(),);
  }
}
