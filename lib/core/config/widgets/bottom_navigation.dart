import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wisp/core/config/constants/base_scaffold.dart';
import 'package:wisp/core/config/constants/colors.dart';

class BottomNavigation extends StatefulWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;

  const BottomNavigation({
    super.key,
    required this.child,
    this.appBar,
  });

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  final _tabs = [
    '/chat',
    '/profile',
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: widget.appBar,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: WispColors.deepBlue3,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: WispColors.grey,
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
