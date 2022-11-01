import 'package:object_guesser/pages/login_page.dart';
import 'package:object_guesser/pages/about_page.dart';
import 'package:object_guesser/pages/home_page.dart';
import 'package:object_guesser/pages/quiz_page.dart';

var appRoutes = {
  '/': (context) => const LoginPage(),
  '/about': (context) => const AboutPage(),
  '/home': (context) => const HomePage(),
  '/quiz': (context) => const QuizPage()
};
