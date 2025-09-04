import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisp/core/config/configurations.dart';
import 'package:wisp/core/config/constants/theme.dart';
import 'package:wisp/core/config/router/route.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const ProviderScope(child: Wisp()));
}

class Wisp extends StatelessWidget {
  const Wisp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      theme: wispTheme,
    );
  }
}
