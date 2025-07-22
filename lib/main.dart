import 'package:flutter/material.dart';
import 'package:wisp/core/di/injection.dart';

Future<void> main () async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(Wisp());
}


class Wisp extends StatelessWidget {
  const Wisp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}