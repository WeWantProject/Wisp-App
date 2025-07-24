import 'package:flutter/material.dart';
import 'package:wisp/core/config/constans/theme.dart';

class BaseScoffold extends StatelessWidget {
  final Widget child;
  final AppBar? appBar;

  const BaseScoffold({super.key, required this.child, this.appBar});

  @override
  Widget build(BuildContext context) {

    final gradient = wispTheme.extension<GradientTheme>()?.backgroundGradient;

    return Scaffold(
      appBar: appBar,
      body: Container(
        decoration: BoxDecoration(
          gradient: gradient,
        ),
        child: child,
      ),
    );
  }
}