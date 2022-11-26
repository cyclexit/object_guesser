import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:object_guesser/firebase_options.dart';
import 'package:object_guesser/config/routes.dart';
import 'package:object_guesser/config/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      routes: appRoutes,
      onGenerateRoute: generateRoute,
    );
  }
}
