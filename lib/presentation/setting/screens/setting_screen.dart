import 'package:flutter/material.dart';
import 'package:wisp/core/config/constants/base_scaffold.dart';
import 'package:wisp/presentation/setting/widgets/setting_appbar.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(
      appBar: SettingAppbar(
        title: "설정",
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(vertical: 14, horizontal: 16),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}

class _SettingItem extends StatelessWidget {
  final List<Widget> children;
  final String title;
  final Icon icon;

  const _SettingItem({
    required this.children,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              icon,
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          ...children,
        ],
      ),
    );
  }
}
