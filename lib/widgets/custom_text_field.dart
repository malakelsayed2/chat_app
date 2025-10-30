import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    required this.validator,
    required this.controller,
    this.keyboardType,
    this.isPassword = false,
    this.suffixIcon,
    this.onPressedSuffixIcon,
  });
  final String hintText;
  IconData? prefixIcon;
  IconData? suffixIcon;
  VoidCallback? onPressedSuffixIcon;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  TextInputType? keyboardType;
  bool isPassword;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon, color: Colors.grey),
        suffixIcon: IconButton(
          onPressed: onPressedSuffixIcon,
          icon: Icon(suffixIcon),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
