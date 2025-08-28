import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wisp/core/config/constants/colors.dart';

class SettingAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const SettingAppbar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: WispColors.deepBlue1,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        onPressed: () => context.pop(),
      ),
      centerTitle: false,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
