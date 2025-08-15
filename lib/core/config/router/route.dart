import 'package:go_router/go_router.dart';
import 'package:wisp/core/config/widgets/bottom_navigation.dart';
import 'package:wisp/presentation/auth/screens/auth_screen.dart';
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
    ],
  );
}
