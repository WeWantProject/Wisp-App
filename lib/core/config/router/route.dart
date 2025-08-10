import 'package:go_router/go_router.dart';
import 'package:wisp/core/config/widgets/bottom_navigation.dart';
import 'package:wisp/presentation/auth/screens/auth_screen.dart';
import 'package:wisp/presentation/chat/screens/chat_list_screen.dart';
import 'package:wisp/presentation/profile/screens/profile_screen.dart';
import 'package:wisp/presentation/splash/screens/splash_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return BottomNavigation(child: child);
        },
        routes: [
          GoRoute(
            path: '/chat',
            builder: (context, state) => const ChatListScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      )
    ],
  );
}
