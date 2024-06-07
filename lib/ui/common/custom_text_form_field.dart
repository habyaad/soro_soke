import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final bool? autoFocus;
  final FocusNode? focusNode;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
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
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.autoFocus,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus ?? false,
      focusNode: focusNode,
      controller: controller,
      obscureText: obscureText ?? false,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
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
          counterStyle: const TextStyle(color: Colors.white60)),
      validator: validator,
    );
  }
}
