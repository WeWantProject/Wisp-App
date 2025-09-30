import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisp/core/config/constants/base_scaffold.dart';
import 'package:wisp/presentation/auth/controller/auth_controller.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const storage = FlutterSecureStorage();

    final notifier = ref.watch(authControllerProvider.notifier);

    final dotIndex = useState(0);

    useEffect(() {
      final timer = Timer.periodic(const Duration(milliseconds: 700), (timer) {
        dotIndex.value = (dotIndex.value + 1) % 3;
      });
      return () => timer.cancel();
    }, []);

    final controller = useAnimationController(
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    final logoScale = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    final textFadeIn = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    useEffect(() {
      Future<void> checkToken() async {
        await Future.delayed(const Duration(seconds: 3)); // Splash 애니메이션 대기용

        final now = DateTime.now().toUtc();
        final accessToken = await storage.read(key: 'accessToken');
        final accessExpireStr = await storage.read(
          key: 'accessTokenExpiration',
        );
        final refreshToken = await storage.read(key: 'refreshToken');
        final refreshExpireStr = await storage.read(
          key: 'refreshTokenExpiration',
        );

        // 액세스 토큰 없으면 로그인
        if (accessToken == null || accessToken.isEmpty) {
          context.go('/auth');
          return;
        }

        // 액세스 토큰 만료일 파싱
        final accessExpire = accessExpireStr != null
            ? DateTime.tryParse(accessExpireStr)?.toUtc()
            : null;

        if (accessExpire == null) {
          // 잘못된 만료일 → 로그아웃
          await storage.deleteAll();
          if (!context.mounted) return;
          context.go('/auth');
          return;
        }

        if (now.isBefore(accessExpire)) {
          // 액세스 토큰 아직 유효 → 바로 메인 이동
          context.go('/main');
          return;
        }

        // 액세스 토큰 만료 → 리프레시 토큰 검사
        if (refreshToken == null ||
            refreshToken.isEmpty ||
            refreshExpireStr == null) {
          await storage.deleteAll();
          if (!context.mounted) return;
          context.go('/auth');
          return;
        }

        final refreshExpire = DateTime.tryParse(refreshExpireStr)?.toUtc();
        if (refreshExpire == null || now.isAfter(refreshExpire)) {
          // 리프레시 토큰 만료 → 로그아웃
          await storage.deleteAll();
          if (!context.mounted) return;
          context.go('/auth');
          return;
        }

        // 리프레시 토큰 유효 → 새 토큰 발급
        try {
          final newTokens = await notifier.refreshToken();

          await storage.write(key: 'accessToken', value: newTokens.accessToken);
          await storage.write(
            key: 'refreshToken',
            value: newTokens.refreshToken,
          );
          await storage.write(
            key: 'accessTokenExpiration',
            value: newTokens.accessTokenExpiration.toIso8601String(),
          );
          await storage.write(
            key: 'refreshTokenExpiration',
            value: newTokens.refreshTokenExpiration.toIso8601String(),
          );

          context.go('/main');
        } catch (e) {
          // 재발급 실패 → 로그아웃
          await storage.deleteAll();
          if (!context.mounted) return;
          context.go('/auth');
        }
      }

      checkToken();
      return null;
    }, []);

    return BaseScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: logoScale,
              child: SvgPicture.asset('assets/images/wisp_logo.svg'),
            ),
            const SizedBox(height: 20),
            const Text('Wisp', style: TextStyle(color: Colors.white)),
            const Text(
              '가벼운 소통, 깊은 연결',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                final isSeleted = dotIndex.value == index;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: AnimatedSlide(
                    offset: isSeleted ? const Offset(0, -0.5) : Offset.zero,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: CircleAvatar(
                      radius: 4,
                      backgroundColor: isSeleted ? Colors.white : Colors.grey,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            FadeTransition(
              opacity: textFadeIn,
              child: const Text(
                '앱을 준비하고 있습니다...',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
