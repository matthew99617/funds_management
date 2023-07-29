import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:funds_management/presentation/router/router.gr.dart';

import '../../shared/bottomNav.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        HomeRouter(),
        CalendarRouter(),
        RecordRouter(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) => BottomNav(
        tabsRouter: tabsRouter,
      ),
    );
  }
}
