import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'icons_data.dart';

class BottomNav extends StatefulWidget {
  final TabsRouter tabsRouter;

  const BottomNav({super.key, required this.tabsRouter});

  @override
  State<BottomNav> createState() => _BottomNavState();
}
class _BottomNavState extends State<BottomNav> {

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items:  const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(homeIcon),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(calendarIcon),
          label: "Calendar",
        ),
        BottomNavigationBarItem(
          icon: Icon(recordIcon,),
          label: "Record",
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(settingIcon),
        //   label: "Setting",
        // ),
      ],
      currentIndex: widget.tabsRouter.activeIndex,
      onTap: widget.tabsRouter.setActiveIndex,
    );
  }
}