import 'package:object_guesser/ui/pages/login/login.dart';
import 'package:object_guesser/ui/pages/about/about.dart';
import 'package:object_guesser/ui/pages/home/home.dart';

var appRoutes = {
  '/': (context) => const LoginPage(),
  '/about': (context) => const AboutPage(),
  '/home': (context) => const HomePage()
};
