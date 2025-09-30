import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:wisp/core/config/constants/colors.dart';

ThemeData wispTheme = ThemeData(
  splashFactory: NoSplash.splashFactory,
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.transparent,
  extensions: const <ThemeExtension<dynamic>>[
    GradientTheme(
      backgroundGradient: LinearGradient(
        colors: [
          WispColors.nightBlack,
          WispColors.deepBlue1,
          WispColors.deepBlue2,
          WispColors.deepBlue3,
          WispColors.deepPurple,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ],
);

@immutable
class GradientTheme extends ThemeExtension<GradientTheme> {
  final LinearGradient backgroundGradient;

  const GradientTheme({required this.backgroundGradient});

  @override
  GradientTheme copyWith({LinearGradient? backgroundGradient}) {
    return GradientTheme(
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
    );
  }

  @override
  GradientTheme lerp(ThemeExtension<GradientTheme>? other, double t) {
    if (other is! GradientTheme) return this;

    final thisColors = backgroundGradient.colors;
    final otherColors = other.backgroundGradient.colors;
    final minLength = math.min(
      backgroundGradient.colors.length,
      other.backgroundGradient.colors.length,
    );

    return GradientTheme(
      backgroundGradient: LinearGradient(
        colors: List.generate(
          minLength,
          (index) => Color.lerp(thisColors[index], otherColors[index], t)!,
        ),
        begin:
            AlignmentGeometry.lerp(
              backgroundGradient.begin,
              other.backgroundGradient.begin,
              t,
            ) ??
            Alignment.topLeft,
        end:
            AlignmentGeometry.lerp(
              backgroundGradient.end,
              other.backgroundGradient.end,
              t,
            ) ??
            Alignment.bottomRight,
      ),
    );
  }
}
