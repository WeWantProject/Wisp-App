import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wisp/core/config/widgets/bottom_navigation.dart';
import 'package:wisp/presentation/auth/screens/auth_screen.dart';
import 'package:wisp/presentation/chat/screens/chat_list_screen.dart';
import 'package:wisp/presentation/chat/widgets/chat_list_appbar.dart';
import 'package:wisp/presentation/profile/screens/profile_screen.dart';
import 'package:wisp/presentation/splash/screens/splash_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/auth',
        name: 'auth',
        builder: (context, state) => const AuthScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          PreferredSizeWidget? appBar;
          if (state.name == '/chat') {
            appBar = const ChatListAppbar();
          } else if (state.name == '/profile') {
            // 프로필 화면 앱바
          }

          return BottomNavigation(
            appBar: appBar,
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/chat',
            name: 'chat',
            builder: (context, state) => const ChatListScreen(),
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      )
    ],
  );
}
