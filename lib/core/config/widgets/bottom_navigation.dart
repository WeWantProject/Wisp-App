import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wisp/core/config/constants/base_scaffold.dart';
import 'package:wisp/core/config/constants/colors.dart';
import 'package:wisp/core/config/constants/theme.dart';

class BottomNavigation extends StatefulWidget {
  final Widget child;

  const BottomNavigation({super.key, required this.child});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  final _tabs = [
    'chat',
    'profile',
  ];

  final backgroundColor =
      wispTheme.extension<GradientTheme>()?.backgroundGradient.colors.first;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: backgroundColor,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: WispColors.deepBlue3,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          context.go(_tabs[index]);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '프로필',
          ),
        ],
      ),
      child: widget.child,
    );
  }
}
