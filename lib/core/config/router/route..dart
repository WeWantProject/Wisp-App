import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:wisp/presentation/auth/screens/auth_screen.dart';
import 'package:wisp/presentation/splash/screens/splash_screen.dart';

class RouterPaths {
  static const String splash = '/splash';
  static const String auth = '/auth';
}

@Singleton()
class AppRouter {
  GoRouter get router => GoRouter(
    initialLocation: RouterPaths.splash,
    routes: [
      GoRoute(
        path: RouterPaths.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouterPaths.auth,
        builder: (context, state) => const AuthScreen(),
      ),
    ],
  );
}