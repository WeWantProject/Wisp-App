import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisp/core/config/constants/colors.dart';
import 'package:wisp/presentation/auth/controller/auth_controller.dart';
import 'package:wisp/presentation/profile/widgets/profile_item.dart';

class ProfileScreen extends StatelessWidget {
  final String userName;
  final String statusMessage;

  const ProfileScreen({
    super.key,
    required this.userName,
    required this.statusMessage,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileTop(userName: userName, statusMessage: statusMessage),
            const Gap(20),
            const Expanded(
              child: SingleChildScrollView(child: ProfileBottom()),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileTop extends StatelessWidget {
  final String userName;
  final String statusMessage;

  const ProfileTop({
    super.key,
    required this.userName,
    required this.statusMessage,
  });

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
        const Gap(20),
        Text(
          userName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          statusMessage,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const Gap(20),
        ElevatedButton(
          onPressed: () {
            // 프로필 편집 구현 예정
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(WispColors.deepBlue1),
            side: WidgetStateProperty.all(
              const BorderSide(color: Colors.white, width: 1),
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

class ProfileBottom extends StatelessWidget {
  const ProfileBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        ProfileItem(
          color: Colors.blue,
          title: '계정 설정',
          icon: const Icon(Icons.settings, color: Colors.blue),
          onTap: () => context.pushNamed('setting'),
          description: '계정 설정',
        ),
        ProfileItem(
          color: Colors.red,
          title: '친구 초대',
          icon: const Icon(Icons.share, color: Colors.red),
          onTap: () => context.pushNamed('addFriend'),
          description: 'Wisp을 친구들에게 추천하세요',
        ),
        const _LogoutButton(),
      ],
    );
  }
}

class _LogoutButton extends ConsumerWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(authControllerProvider.notifier);

    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(16),
        backgroundColor: Colors.red.withValues(alpha: 0.1),
        foregroundColor: Colors.red.shade400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.red.withValues(alpha: 0.2)),
        ),
      ),
      onPressed: () async {
        await notifier.logout();
        context.go("/auth");
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.logout, color: Colors.red, size: 20),
          Gap(8),
          Text(' 로그아웃', style: TextStyle(color: Colors.red, fontSize: 16)),
        ],
      ),
    );
  }
}
