import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  final String title;
  final String description;
  final Widget icon;
  final MaterialColor color;

  const ProfileItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.description,
      required this.color});

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
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1), // bg-red-500/10
                border: Border.all(
                  color: color.withOpacity(0.2), // border-red-400/20
                ),
                borderRadius: BorderRadius.circular(12), // rounded-xl
              ),
              child: icon,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
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
