import 'package:chat_app/views/sign_in_screen.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 5,
                      offset: Offset(5, 5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.person_add,
                  color: Colors.white,
                  size: 70,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Join Our Community!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const SizedBox(height: 10),
              const Text(
                "Create your account to start chatting with friends",
                style: TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10,
                      offset: Offset(5, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(30),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        hintText: 'Username',
                        prefixIcon: CupertinoIcons.person,
                        validator: (String? value) {
                          if (value!.length < 5) {
                            return 'Username must be at least 5 characters';
                          }
                          return null;
                        },
                        controller: usernameController,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        hintText: 'Email',
                        prefixIcon: Icons.email_outlined,
                        validator: (String? value) {
                          if (!value!.contains("@")) {
                            return "Invalid email!";
                          }
                          return null;
                        },
                        controller: emailController,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        prefixIcon: CupertinoIcons.padlock,
                        suffixIcon: isPasswordHidden
                            ? CupertinoIcons.eye_slash
                            : CupertinoIcons.eye,
                        validator: (String? value) {
                          if (value!.length < 8) {
                            return "Password must be at least 8 characters";
                          }
                          return null;
                        },
                        onPressedSuffixIcon: () {
                          setState(() {
                            isPasswordHidden = !isPasswordHidden;
                          });
                        },
                        isPassword: isPasswordHidden,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: confirmPassController,
                        hintText: 'Confirm Password',
                        prefixIcon: CupertinoIcons.padlock,
                        validator: (String? value) {
                          if (value != passwordController.text) {
                            return "Passwords don't match!";
                          }
                          return null;
                        },
                        isPassword: isPasswordHidden,
                      ),
                      const SizedBox(height: 30),
                      CustomButton(
                        labelText: "Create Account",
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await FirebaseService.register(
                              emailController.text,
                              passwordController.text,
                              usernameController.text,
                              context,
                            );
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Have an account?",
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignInScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
