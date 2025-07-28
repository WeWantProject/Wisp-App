import 'package:injectable/injectable.dart';
import 'package:wisp/main.dart';
import 'package:wisp/presentation/auth/screens/auth_screen.dart';
import 'package:wisp/presentation/splash/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

class RouterPaths {
  static const String splash = '/splash';
  static const String auth = '/auth';
  static const String main = '/';
}

@Singleton()
class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: RouterPaths.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouterPaths.auth,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: RouterPaths.main,
        builder: (context, state) => const Main(),
      ),
    ],
  );
}