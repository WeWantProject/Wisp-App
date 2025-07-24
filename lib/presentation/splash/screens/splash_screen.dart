import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wisp/core/config/constans/base_scoffold.dart';
import 'package:wisp/core/config/constans/colors.dart';

class SplashScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {

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

    final logoScale = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    final textFadeIn = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    useEffect(() {
      Timer(const Duration(seconds: 5), () {
      context.pushReplacement('/login');
      });
    }, []);

    return BaseScoffold(
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: logoScale,
                child: SvgPicture.asset(
                  'assets/images/wisp_logo.svg'
                ),
              ),
              const SizedBox(height: 20,),
              const Text(
                'Wisp',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              const Text(
                '가벼운 소통, 깊은 연결',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3, (index) {
                    final isSeleted = dotIndex.value == index;
                    return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: AnimatedSlide(
                      offset: isSeleted ? Offset(0, -0.5) : Offset.zero,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: CircleAvatar(
                        radius: 4,
                        backgroundColor: isSeleted ? Colors.white : Colors.grey,
                      ),
                    ),
                  );
                  }
                ),
              ),
              const SizedBox(height: 20,),
              FadeTransition(
                opacity: textFadeIn,
                child: const Text(
                  '앱을 준비하고 있습니다...',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }
}