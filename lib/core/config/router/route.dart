import 'package:go_router/go_router.dart';
import 'package:wisp/core/config/widgets/bottom_navigation.dart';
import 'package:wisp/presentation/auth/screens/auth_screen.dart';
import 'package:wisp/presentation/chat/screens/chat_list_screen.dart';
import 'package:wisp/presentation/chat/screens/chat_screen.dart';
import 'package:wisp/presentation/setting/screens/add_friend_screen.dart';
import 'package:wisp/presentation/setting/screens/setting_screen.dart';
import 'package:wisp/presentation/splash/screens/splash_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      /// Splash
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      /// Auth
      GoRoute(
        path: '/auth',
        name: 'auth',
        builder: (context, state) => const AuthScreen(),
      ),

      /// Main (BottomNavigation)
      GoRoute(
        path: '/main',
        name: 'main',
        builder: (context, state) => const BottomNavigation(),
      ),

      /// Chat
      GoRoute(
        path: '/chat',
        name: 'chat',
        builder: (context, state) => const ChatListScreen(),
      ),
      GoRoute(
        path: '/chat/:chatId',
        name: 'chatDetail',
        builder: (context, state) {
          final chatId = state.pathParameters['chatId']!;
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final userName = extra['userName'] ?? '사용자 이름';
          final isOnline = extra['isOnline'] ?? false;

          return ChatScreen(
            chatId: chatId,
            userName: userName,
            isOnline: isOnline,
          );
        },
      ),

      GoRoute(
        path: '/setting',
        name: 'setting',
        builder: (context, state) => const SettingScreen(),
        routes: [
          GoRoute(
            path: 'add-friend',
            name: 'addFriend',
            builder: (context, state) => const AddFriendScreen(),
          ),
        ],
      ),
    ],
  );
}
