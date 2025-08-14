import 'package:flutter/material.dart';
import 'package:wisp/core/config/constants/base_scaffold.dart';
import 'package:wisp/core/config/constants/colors.dart';
import 'package:wisp/presentation/chat/screens/chat_list_screen.dart';
import 'package:wisp/presentation/chat/widgets/chat_list_appbar.dart';
import 'package:wisp/presentation/profile/screens/profile_screen.dart';
import 'package:wisp/presentation/profile/widgets/profile_appbar.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  final _pages = const [
    ChatListScreen(),
    ProfileScreen(userName: '황지훈', statusMessage: '멋진 남자 좋아해용 ㅎㅎ',),
  ];

  final List<PreferredSizeWidget> _appBars = const [
    ChatListAppbar(),
    ProfileAppbar(),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: _appBars[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: WispColors.deepBlue3,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: WispColors.grey,
        onTap: (index) {
          setState(() => _currentIndex = index);
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
      child: Stack(
        children: List.generate(_pages.length, (index) {
          return Offstage(
            offstage: _currentIndex != index,
            child: _pages[index],
          );
        }),
      ),
    );
  }
}
