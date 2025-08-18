import 'package:go_router/go_router.dart';
import 'package:wisp/core/config/widgets/bottom_navigation.dart';
import 'package:wisp/presentation/auth/screens/auth_screen.dart';
import 'package:wisp/presentation/chat/screens/chat_list_screen.dart';
import 'package:wisp/presentation/chat/screens/chat_screen.dart';
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
      GoRoute(
        path: '/main',
        name: 'main',
        builder: (context, state) => const BottomNavigation(),
      ),
      GoRoute(
          path: '/chat',
          name: 'chat',
          builder: (context, state) {
            return const ChatListScreen();
          }),
      GoRoute(
        path: '/chat/:chatId',
        name: 'chatDetail',
        builder: (context, state) {
          final chatId = state.pathParameters['chatId']!;
          final userName =
              state.extra is Map ? (state.extra as Map)['userName'] : '사용자 이름';
          final isOnline = state.extra is Map
              ? (state.extra as Map)['isOnline'] ?? false
              : false;
          return ChatScreen(
            chatId: chatId,
            userName: userName,
            isOnline: isOnline,
          );
        },
      ),
    ],
  );
}
