import 'package:flutter/material.dart';

import 'package:object_guesser/config/routes.dart';
import 'package:object_guesser/config/themes.dart';

void main() {
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
