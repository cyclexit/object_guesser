import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle _optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      ElevatedButton(
          onPressed: (() => Navigator.pushNamed(context, '/quiz')),
          child: const Text("play")),
      const Text(
        'User Profile',
        style: _optionStyle,
      ),
    ];

    return Scaffold(
      body: Center(child: widgetOptions[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.gamepad,
              size: 20,
            ),
            label: 'Play',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.circleUser,
              size: 20,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
