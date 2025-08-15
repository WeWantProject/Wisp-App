import 'package:flutter/material.dart';
import 'package:wisp/core/config/constants/colors.dart';
import 'package:wisp/presentation/profile/widgets/profile_item.dart';

class ProfileScreen extends StatelessWidget {
  final String userName;
  final String statusMessage;

  const ProfileScreen(
      {super.key, required this.userName, required this.statusMessage});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Center(
          child: Column(
            children: [
              ProfileTop(userName: userName, statusMessage: statusMessage),
              const SizedBox(height: 20),
              const Expanded(
                child: SingleChildScrollView(
                  child: ProfileBottom(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileTop extends StatelessWidget {
  final String userName;
  final String statusMessage;

  const ProfileTop(
      {super.key, required this.userName, required this.statusMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          child: Icon(
            Icons.person,
            size: 50,
            color: Colors.white,
          ), // api를 통해 불러올 예정
        ),
        const SizedBox(height: 20),
        Text(
          userName,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          statusMessage,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // 프로필 편집 구현 예정
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(WispColors.deepBlue1),
            side: MaterialStateProperty.all(
              BorderSide(color: Colors.white, width: 1),
            ),
          ),
          child: const Text(
            '프로필 편집',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class ProfileTopButton extends StatelessWidget {
  final Icon icon;
  final String title;

  const ProfileTopButton({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Column(
        children: [
          icon,
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class ProfileBottom extends StatelessWidget {
  const ProfileBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        const ProfileItem(
          color: Colors.blue,
          title: '계정 설정',
          icon: Icon(
            Icons.settings,
            color: Colors.blue,
          ),
          description: '개인정보 및 보안 설정',
        ),
        const ProfileItem(
          color: Colors.amber,
          title: '알림 설정',
          icon: Icon(Icons.notifications, color: Colors.amber),
          description: '알림 및 소리 설정',
        ),
        const ProfileItem(
          color: Colors.red,
          title: '친구 초대',
          icon: Icon(Icons.share, color: Colors.red),
          description: 'Wisp을 친구들에게 추천하세요',
        ),
        const ProfileItem(
          color: Colors.purple,
          title: '테마 설정',
          icon: Icon(Icons.palette, color: Colors.purple),
          description: '다크/라이트 모드 및 색상',
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(16),
            backgroundColor: Colors.red.withOpacity(0.1),
            foregroundColor: Colors.red.shade400,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: Colors.red.withOpacity(0.2),
              ),
            ),
          ),
          onPressed: () {},
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout,
                color: Colors.red,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                ' 로그아웃',
                style: TextStyle(color: Colors.red, fontSize: 16),
              )
            ],
          ),
        )
      ],
    );
  }
}
