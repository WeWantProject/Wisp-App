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
    var _storage = FlutterSecureStorage();

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
        await Future.delayed(const Duration(seconds: 2));

        final now = DateTime.now().toUtc();
        final accessToken = await _storage.read(key: 'accessToken');
        final accessExpireStr = await _storage.read(
          key: 'accessTokenExpiration',
        );
        final refreshToken = await _storage.read(key: 'refreshToken');
        final refreshExpireStr = await _storage.read(
          key: 'refreshTokenExpiration',
        );

        // 토큰이 없을 경우
        if (accessToken == null || accessToken.isEmpty) {
          context.go('/auth');
          return;
        }

        if (accessExpireStr != null) {
          final accessExpire = DateTime.parse(accessExpireStr).toUtc();

          // access token 만료 1분 전이면 refresh 시도
          if (now.isAfter(accessExpire.subtract(const Duration(minutes: 1)))) {
            if (refreshToken != null &&
                refreshToken.isNotEmpty &&
                refreshExpireStr != null) {
              final refreshExpire = DateTime.parse(refreshExpireStr).toUtc();

              if (now.isBefore(refreshExpire)) {
                try {
                  // 새 토큰 발급
                  final newTokens = await notifier.refreshToken();

                  // secure storage에 저장
                  await _storage.write(
                    key: 'accessToken',
                    value: newTokens.accessToken,
                  );
                  await _storage.write(
                    key: 'refreshToken',
                    value: newTokens.refreshToken,
                  );
                  await _storage.write(
                    key: 'accessTokenExpiration',
                    value: newTokens.accessTokenExpiration.toIso8601String(),
                  );
                  await _storage.write(
                    key: 'refreshTokenExpiration',
                    value: newTokens.refreshTokenExpiration.toIso8601String(),
                  );
                } catch (e) {
                  context.go('/auth');
                  return;
                }
              } else {
                context.go('/auth');
                _storage.deleteAll();
                return;
              }
            } else {
              context.go('/auth');
              return;
            }
          }
        }
        context.go('/auth');
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
