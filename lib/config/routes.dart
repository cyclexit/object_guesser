import 'package:object_guesser/pages/login_page.dart';
import 'package:object_guesser/pages/about_page.dart';
import 'package:object_guesser/pages/main_page.dart';
import 'package:object_guesser/pages/quiz_page.dart';

var appRoutes = {
  MainPage.routeName: (context) => const MainPage(),
  AboutPage.routeName: (context) => const AboutPage(),
  QuizPage.routeName: (context) => const QuizPage(),
  LoginPage.routeName: (context) => const LoginPage(),
};
