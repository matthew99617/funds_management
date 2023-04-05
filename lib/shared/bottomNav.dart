import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:funds_management/shared/colors.dart';

import 'icons_data.dart';

class BottomNav extends StatefulWidget {

  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}
class _BottomNavState extends State<BottomNav> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        // AutoRouter.of(context).pushNamed("/setting_screen");
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items:  const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(homeIcon),
          label: "Home",
          backgroundColor: darkBackground,
        ),
        BottomNavigationBarItem(
          icon: Icon(calendarIcon),
          label: "Calendar",
          backgroundColor: darkBackground,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            recordIcon,
          ),
          label: "Record",
          backgroundColor: darkBackground,
        ),
        BottomNavigationBarItem(
          icon: Icon(settingIcon),
          label: "Setting",
          backgroundColor: darkBackground,
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}