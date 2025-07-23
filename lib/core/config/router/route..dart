import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:wisp/main.dart';
import 'package:wisp/presentation/login/screens/login_screen.dart';
import 'package:wisp/presentation/splash/screens/splash_screen.dart';

class RouterPaths {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String main = '/';
}

@Singleton()
class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: RouterPaths.splash,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: RouterPaths.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouterPaths.main,
        builder: (context, state) => const Main(),
      ),
    ],
  );
}