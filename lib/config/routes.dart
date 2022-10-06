import 'package:object_guesser/pages/login.dart';
import 'package:object_guesser/pages/about.dart';
import 'package:object_guesser/pages/home.dart';

var appRoutes = {
  '/': (context) => const LoginPage(),
  '/about': (context) => const AboutPage(),
  '/home': (context) => const HomePage()
};
