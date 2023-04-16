// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../screen/home/home_screen.dart' as _i2;
import '../screen/main_home_page.dart' as _i1;
import '../screen/setting/setting_screen.dart' as _i3;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    MainHomeRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.MainHomePage(),
      );
    },
    HomeRouter.name: (routeData) {
      final args = routeData.argsAs<HomeRouterArgs>(
          orElse: () => const HomeRouterArgs());
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.HomeScreen(key: args.key),
      );
    },
    SettingRouter.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.SettingScreen(),
      );
    },
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(
          MainHomeRoute.name,
          path: '/',
          children: [
            _i4.RouteConfig(
              HomeRouter.name,
              path: 'home',
              parent: MainHomeRoute.name,
            ),
            _i4.RouteConfig(
              SettingRouter.name,
              path: 'setting',
              parent: MainHomeRoute.name,
            ),
          ],
        )
      ];
}

/// generated route for
/// [_i1.MainHomePage]
class MainHomeRoute extends _i4.PageRouteInfo<void> {
  const MainHomeRoute({List<_i4.PageRouteInfo>? children})
      : super(
          MainHomeRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'MainHomeRoute';
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRouter extends _i4.PageRouteInfo<HomeRouterArgs> {
  HomeRouter({_i5.Key? key})
      : super(
          HomeRouter.name,
          path: 'home',
          args: HomeRouterArgs(key: key),
        );

  static const String name = 'HomeRouter';
}

class HomeRouterArgs {
  const HomeRouterArgs({this.key});

  final _i5.Key? key;

  @override
  String toString() {
    return 'HomeRouterArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.SettingScreen]
class SettingRouter extends _i4.PageRouteInfo<void> {
  const SettingRouter()
      : super(
          SettingRouter.name,
          path: 'setting',
        );

  static const String name = 'SettingRouter';
}
