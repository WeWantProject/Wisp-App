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
              const SingleChildScrollView(child: ProfileBottom())
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
    return const Column(
      spacing: 16,
      children: [
        ProfileItem(
          color: Colors.blue,
          title: '계정 설정',
          icon: Icon(
            Icons.settings,
            color: Colors.blue,
          ),
          description: '개인정보 및 보안 설정',
        ),
        ProfileItem(
          color: Colors.amber,
          title: '알림 설정',
          icon: Icon(Icons.notifications, color: Colors.amber),
          description: '알림 및 소리 설정',
        ),
        ProfileItem(
          color: Colors.red,
          title: '친구 초대',
          icon: Icon(Icons.share, color: Colors.red),
          description: 'Wisp을 친구들에게 추천하세요',
        ),
        ProfileItem(
          color: Colors.purple,
          title: '테마 설정',
          icon: Icon(Icons.palette, color: Colors.purple),
          description: '다크/라이트 모드 및 색상',
        ),
      ],
    );
  }
}
