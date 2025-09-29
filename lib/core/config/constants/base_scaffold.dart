import 'package:flutter/material.dart';
import 'package:wisp/core/config/constants/theme.dart';

class BaseScaffold extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;
  final BottomNavigationBar? bottomNavigationBar;

  const BaseScaffold({
    super.key,
    required this.child,
    this.appBar,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    final gradient = wispTheme.extension<GradientTheme>()?.backgroundGradient;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBar,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(gradient: gradient),
          child: child,
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
