import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wisp/core/config/constants/base_scaffold.dart';
import 'package:wisp/core/config/constants/colors.dart';
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
            children: [
              _SettingTile(
                title: "기본 설정",
                icon: Icon(
                  Icons.settings_outlined,
                  color: Colors.amber,
                ),
                children: [
                  _SettingItem(
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: Colors.orange,
                    ),
                    title: "알림",
                    content: "메시지 및 통화 알림",
                    active: Switch(
                      value: true,
                      onChanged: null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  final List<Widget> children;
  final String title;
  final Icon icon;

  const _SettingTile({
    required this.children,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            children: [
              icon,
              const Gap(10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Gap(20),
          ...children,
        ],
      ),
    );
  }
}

class _SettingItem extends StatelessWidget {
  final Icon icon;
  final String title;
  final String content;
  final Widget active;

  const _SettingItem({
    required this.icon,
    required this.title,
    required this.content,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          icon,
          const Gap(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 14,
                  color: WispColors.lightSkyBlue,
                ),
              ),
            ],
          ),
          const Spacer(),
          active,
        ],
      ),
    );
  }
}
