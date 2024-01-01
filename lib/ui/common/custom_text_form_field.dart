import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final String? Function(String?)? validator;
  final Icon? prefixIcon;
  final bool? obscureText;
  final Widget? suffix;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.keyboardType,
    this.hintText,
    this.validator,
    this.prefixIcon,
    this.obscureText,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        //focusColor: Colors.white,
        suffixIcon: suffix,
        hintText: hintText,
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: Colors.purple[50],
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
      validator: validator,
    );
  }
}
