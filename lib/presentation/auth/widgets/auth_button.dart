import 'package:flutter/material.dart';
import 'package:wisp/core/config/constans/colors.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const AuthButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 50,
      decoration: BoxDecoration(
          color: WispColors.deepBlue2,
          borderRadius: BorderRadius.circular(12)),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
