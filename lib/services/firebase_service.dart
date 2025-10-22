import 'package:chat_app/views/home_screen.dart';
import 'package:chat_app/views/verification_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseService{

  static Future<bool> checkVerificationStatus()async{

    FirebaseAuth.instance.currentUser!.reload();
    return FirebaseAuth.instance.currentUser!.emailVerified;

  }

  static Future<void> register(String email,String password,String userName, BuildContext context)async{

    try{

      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password);

      await credential.user!.updateDisplayName(userName);

      // await credential.user!.sendEmailVerification();

      await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).set({
        "email": email,
        "username": userName
      });

      Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationScreen(),));


    }catch(e){
      print(e.toString());
    }

  }
  static Future<void> login(String email,String password,BuildContext context)async{
    try{

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);


      if(FirebaseAuth.instance.currentUser!.emailVerified){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
     }
     else{
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VerificationScreen(),));
     }

    }catch(e){

    }
  }
}