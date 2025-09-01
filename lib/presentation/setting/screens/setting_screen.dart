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
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              spacing: 20,
              children: [
                _BasicSettings(),
                _InformationSettings(),
                _LanguageSettings(),
                _AccountSettings(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BasicSettings extends StatefulWidget {
  const _BasicSettings();

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
  const _InformationSettings();

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
            Icons.shield_outlined,
            color: Colors.purpleAccent,
          ),
          title: "프로필 공개 범위",
          content: "누가 내 프로필을 볼 수 있는지 설정",
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

class _LanguageSettings extends StatefulWidget {
  const _LanguageSettings();

  @override
  State<_LanguageSettings> createState() => __LanguageSettingsState();
}

class __LanguageSettingsState extends State<_LanguageSettings> {
  String selectedValue = '한국어';
  final List<String> options = ['한국어', 'English', '日本語', '中国人'];

  @override
  Widget build(BuildContext context) {
    return _SettingTile(
      title: "언어",
      icon: const Icon(
        Icons.language_outlined,
        color: Colors.blue,
      ),
      children: [
        _SettingItem(
          icon: const Icon(
            Icons.language_outlined,
            color: Colors.blue,
          ),
          title: "앱 언어",
          content: "앱에서 사용할 언어를 선택하세요",
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

class _AccountSettings extends StatelessWidget {
  const _AccountSettings();

  @override
  Widget build(BuildContext context) {
    return const _SettingTile(
      title: "계정 관리",
      icon: Icon(
        Icons.lock_outline,
        color: Colors.orange,
      ),
      children: [
        _SettingItem(
          icon: Icon(
            Icons.lock_outline,
            color: Colors.blue,
          ),
          title: "비밀번호 변경",
          content: "계정 보안을 위해 정기적으로 변경하세요",
        ),
        Gap(16),
        _SettingItem(
          icon: Icon(
            Icons.shield_outlined,
            color: Colors.green,
          ),
          title: "2단계 인증",
          content: "SMS 또는 앱을 통한 추가 보안",
        ),
        Gap(16),
        _SettingItem(
          icon: Icon(
            Icons.delete_outline,
            color: Colors.red,
          ),
          title: "계정 삭제",
          content: "모든 데이터가 영구적으로 삭제됩니다",
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
    this.active = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.5),
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
                  fontSize: 12,
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
