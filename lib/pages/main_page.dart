import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:object_guesser/pages/error_page.dart';
import 'package:object_guesser/pages/home_page.dart';
import 'package:object_guesser/pages/loading_page.dart';
import 'package:object_guesser/pages/login_page.dart';
import 'package:object_guesser/pages/profile_page.dart';
import 'package:object_guesser/services/auth.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/';

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final screens = [const HomePage(), const ProfilePage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthService().userStream,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else if (snapshot.hasError) {
            return ErrorPage(errorMessage: snapshot.error.toString());
          } else if (snapshot.hasData) {
            return Scaffold(
              body: IndexedStack(index: _selectedIndex, children: screens),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.shadow,
                      spreadRadius: 0,
                      blurRadius: 16,
                      offset: const Offset(0, -1),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: BottomNavigationBar(
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(
                            FluentIcons.home_12_filled,
                            size: 32,
                          ),
                          label: 'home'),
                      BottomNavigationBarItem(
                        icon: Icon(
                          FluentIcons.person_12_filled,
                          size: 32,
                        ),
                        label: 'profile',
                      ),
                    ],
                    currentIndex: _selectedIndex,
                    onTap: _onItemTapped,
                  ),
                ),
              ),
            );
          } else {
            return const LoginPage();
          }
        }));
  }
}
