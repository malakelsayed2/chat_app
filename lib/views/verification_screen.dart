import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/services/firebase_service.dart';
import 'package:chat_app/views/home_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late final Timer timer ;
  @override
  void initState() {
    // TODO: implement initState
    FirebaseAuth.instance.currentUser!.sendEmailVerification();
    timer =Timer.periodic(Duration(seconds: 1),(_)async{
      final isVerified = await FirebaseService.checkVerificationStatus() ;
      if(isVerified){
       timer.cancel() ;
       Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingAnimationWidget.horizontalRotatingDots(color: Colors.green, size: 50),
            Text("Verify your account" , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold),),
            Text("Please, check your mail!" , style: TextStyle(fontSize: 17),),
          ],
        ),
      ),
    );
  }
}

