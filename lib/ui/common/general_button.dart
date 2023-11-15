import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/ui_helpers.dart';

class GeneralButton extends StatelessWidget {
  final void Function() onPressed;
  final String buttonText;
  final Color? buttonColor;

  const GeneralButton(
      {super.key,
      required this.onPressed,
      required this.buttonText,
      this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Ink(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: buttonColor ?? kcPrimaryColor),
        width: screenWidth(context) - 20,
        height: 46,
        child: Center(
            child: Text(
          buttonText,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        )),
      ),
    );
  }
}
