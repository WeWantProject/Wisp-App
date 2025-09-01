import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wisp/core/config/constants/base_scaffold.dart';
import 'package:wisp/core/config/constants/colors.dart';
import 'package:wisp/presentation/setting/widgets/setting_appbar.dart';
import 'package:wisp/presentation/setting/widgets/setting_dropdown.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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
            spacing: 20,
            children: [
              _BasicSettings(),
              _InformationSettings(),
            ],
          ),
        ),
      ),
    );
  }
}

class _BasicSettings extends StatefulWidget {
  const _BasicSettings({super.key});

  @override
  State<_BasicSettings> createState() => __BasicSettingsState();
}

class __BasicSettingsState extends State<_BasicSettings> {
  bool _isOn = true;

  @override
  Widget build(BuildContext context) {
    return _SettingTile(
      title: "기본 설정",
      icon: const Icon(
        Icons.settings_outlined,
        color: Colors.amber,
      ),
      children: [
        _SettingItem(
          icon: const Icon(
            Icons.notifications_outlined,
            color: Colors.orange,
          ),
          title: "알림",
          content: "메시지 및 통화 알림",
          active: Switch(
            value: _isOn,
            onChanged: (bool value) {
              setState(() {
                _isOn = value;
              });
            },
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade400,
            activeTrackColor: Colors.black,
          ),
        ),
        const Gap(16),
        _SettingItem(
          icon: Icon(
            _isOn ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
            color: Colors.purpleAccent,
          ),
          title: "다크 테마",
          content: "어두운 테마 사용",
          active: Switch(
            value: _isOn,
            onChanged: (bool value) {
              setState(() {
                _isOn = value;
              });
            },
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade400,
            activeTrackColor: Colors.black,
          ),
        ),
        const Gap(16),
        _SettingItem(
          icon: const Icon(
            Icons.chat_bubble_outline,
            color: Colors.green,
          ),
          title: "읽음 확인",
          content: "메시지 읽음 표시",
          active: Switch(
            value: _isOn,
            onChanged: (bool value) {
              setState(() {
                _isOn = value;
              });
            },
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade400,
            activeTrackColor: Colors.black,
          ),
        ),
      ],
    );
  }
}

class _InformationSettings extends StatefulWidget {
  const _InformationSettings({super.key});

  @override
  State<_InformationSettings> createState() => __InformationSettingsState();
}

class __InformationSettingsState extends State<_InformationSettings> {
  bool _isOn = true;
  String selectedValue = '친구만'; // 초기값

  final List<String> options = ['친구만', '전체공개', '비공개'];

  @override
  Widget build(BuildContext context) {
    return _SettingTile(
      title: "개인정보 보호",
      icon: const Icon(
        Icons.shield_outlined,
        color: Colors.green,
      ),
      children: [
        _SettingItem(
          icon: const Icon(
            Icons.visibility_outlined,
            color: Colors.blue,
          ),
          title: "마지막 접속 시간",
          content: "다른 사용자에게 표시",
          active: Switch(
            value: _isOn,
            onChanged: (bool value) {
              setState(() {
                _isOn = value;
              });
            },
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade400,
            activeTrackColor: Colors.black,
          ),
        ),
        const Gap(16),
        _SettingItem(
          icon: const Icon(
            Icons.people_alt_outlined,
            color: Colors.green,
          ),
          title: "온라인 상태",
          content: "현재 온라인 상태 표시",
          active: Switch(
            value: _isOn,
            onChanged: (bool value) {
              setState(() {
                _isOn = value;
              });
            },
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade400,
            activeTrackColor: Colors.black,
          ),
        ),
        const Gap(16),
        _SettingItem(
          icon: const Icon(
            Icons.chat_bubble_outline,
            color: Colors.green,
          ),
          title: "읽음 확인",
          content: "메시지 읽음 표시",
          active: SettingDropdown(
            options: options,
            selectedValue: selectedValue,
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue!;
              });
            },
          ),
        ),
      ],
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
