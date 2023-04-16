// export PATH="$PATH:/Users/.../flutter_sdk/flutter/bin"
// flutter pub run build_runner watch --delete-conflicting-outputs

import 'package:auto_route/auto_route.dart';
import '../screen/home/home_screen.dart';
import '../screen/main_home_page.dart';
import '../screen/setting/setting_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/', page: MainHomePage, children: [
      AutoRoute(
        path: 'home',
        name: 'HomeRouter',
        page: HomeScreen,
      ),
      AutoRoute(
        path: 'setting',
        name: 'SettingRouter',
        page: SettingScreen,
      )
    ]),
  ],
)

class $AppRouter {}