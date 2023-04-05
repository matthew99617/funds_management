// export PATH="$PATH:/Users/.../flutter_sdk/flutter/bin"
// flutter pub run build_runner watch --delete-conflicting-outputs

import 'package:auto_route/auto_route.dart';
import '../screen/home/home_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/home_screen',
      page: HomeScreen,
      initial: true,
    ),
    // CustomRoute(
    //   path: '/setting_screen',
    //   page: SettingScreen,
    //   transitionsBuilder: TransitionsBuilders.fadeIn,
    // ),
  ],
)

class $AppRouter {}