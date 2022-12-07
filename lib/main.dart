import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:object_guesser/firebase_options.dart';
import 'package:object_guesser/config/routes.dart';
import 'package:object_guesser/config/themes.dart';
import 'package:object_guesser/log.dart';
import 'package:object_guesser/models/user/user_game_history.dart';
import 'package:object_guesser/services/firestore_service.dart';
import 'package:provider/provider.dart';

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
    return StreamProvider(
      create: (context) => FirestoreService().streamUserGameHistory(),
      initialData: UserGameHistory(),
      catchError: (context, error) {
        log.e("Error in stream: ${error.toString()}");
        log.i("This may be a new user.");
        return UserGameHistory();
      },
      child: MaterialApp(
        theme: appTheme,
        routes: appRoutes,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
