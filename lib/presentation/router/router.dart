// export PATH="$PATH:/Users/.../flutter_sdk/flutter/bin"
// flutter pub run build_runner watch --delete-conflicting-outputs

import 'package:auto_route/auto_route.dart';
import '../screen/calendar/calendar_screen.dart';
import '../screen/home/home_screen.dart';
import '../screen/main_home_page.dart';
import '../screen/record/record_screen.dart';
import '../screen/setting/setting_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/', page: MainHomePage, name: 'MainHomePage', children: [
      CustomRoute(
        path: 'home',
        name: 'HomeRouter',
        page: HomeScreen,
      ),
      CustomRoute(
        path: 'calendar',
        name: 'CalendarRouter',
        page: CalendarScreen,
      ),
      CustomRoute(
        path: 'record',
        name: 'RecordRouter',
        page: RecordScreen,
      ),
      CustomRoute(
        path: 'setting',
        name: 'SettingRouter',
        page: SettingScreen,
      )
    ]),
  ],
)
class $AppRouter {}
