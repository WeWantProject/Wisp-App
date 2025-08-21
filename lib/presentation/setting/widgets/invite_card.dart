import 'package:flutter/material.dart';
import 'package:wisp/core/config/constants/colors.dart';

class InviteCard extends StatelessWidget {

  final String title;
  final Widget child;
  
  const InviteCard({super.key, required this.title, required this.child,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        spacing: 20,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: WispColors.lightSkyBlue,
                width: 0.3,
              ),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}