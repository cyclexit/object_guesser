import 'package:object_guesser/pages/login_page.dart';
import 'package:object_guesser/pages/about_page.dart';
import 'package:object_guesser/pages/home_page.dart';
import 'package:object_guesser/pages/quiz_page.dart';

var appRoutes = {
  HomePage.routeName: (context) => const HomePage(),
  AboutPage.routeName: (context) => const AboutPage(),
  QuizPage.routeName: (context) => const QuizPage(),
  LoginPage.routeName: (context) => const LoginPage(),
};
