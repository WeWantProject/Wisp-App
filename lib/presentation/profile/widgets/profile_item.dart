import 'package:flutter/material.dart';


class ProfileItem extends StatelessWidget {
  final String title;
  final String description;
  final Widget icon;
  

  const ProfileItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blueGrey[700]!, width: 1.0),
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14, color: Colors.grey),
                ), 
              ],
            ),
            const Spacer(),
            const Icon(
                color: Colors.white,
                Icons.arrow_forward_ios,
            ),
          ],
        ),
      ),
    );
  }
}
