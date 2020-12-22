import 'package:MeetingApp/screens/users/search_user_screen.dart';
import 'package:flutter/material.dart';

import 'messager/messager_page.dart';
import 'profile/profile_page.dart';

class BottomMenu extends StatefulWidget {
  BottomMenu({Key key}) : super(key: key);

  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  int _selectPageIndx = 0;
  List<Widget> _pages = [
    SearchUserPage(),
    MessagerPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectPageIndx),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Поиск',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline),
            label: 'Сообщения',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectPageIndx,
        selectedItemColor: Colors.purple[800],
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectPageIndx = index;
    });
  }
}
