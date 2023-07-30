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
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../screen/calendar/calendar_screen.dart' as _i4;
import '../screen/home/home_screen.dart' as _i3;
import '../screen/login/login_screen.dart' as _i1;
import '../screen/main_home_page.dart' as _i2;
import '../screen/record/record_screen.dart' as _i5;
import '../screen/setting/setting_screen.dart' as _i6;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    LoginPage.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LoginPage(),
      );
    },
    MainHomePage.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.MainHomePage(),
      );
    },
    HomeRouter.name: (routeData) {
      final args = routeData.argsAs<HomeRouterArgs>(
          orElse: () => const HomeRouterArgs());
      return _i7.CustomPage<dynamic>(
        routeData: routeData,
        child: _i3.HomeScreen(key: args.key),
        opaque: true,
        barrierDismissible: false,
      );
    },
    CalendarRouter.name: (routeData) {
      return _i7.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.CalendarScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    RecordRouter.name: (routeData) {
      final args = routeData.argsAs<RecordRouterArgs>(
          orElse: () => const RecordRouterArgs());
      return _i7.CustomPage<dynamic>(
        routeData: routeData,
        child: _i5.RecordScreen(key: args.key),
        opaque: true,
        barrierDismissible: false,
      );
    },
    SettingRouter.name: (routeData) {
      return _i7.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i6.SettingScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(
          LoginPage.name,
          path: '/',
        ),
        _i7.RouteConfig(
          MainHomePage.name,
          path: '/',
          children: [
            _i7.RouteConfig(
              HomeRouter.name,
              path: 'home',
              parent: MainHomePage.name,
            ),
            _i7.RouteConfig(
              CalendarRouter.name,
              path: 'calendar',
              parent: MainHomePage.name,
            ),
            _i7.RouteConfig(
              RecordRouter.name,
              path: 'record',
              parent: MainHomePage.name,
            ),
            _i7.RouteConfig(
              SettingRouter.name,
              path: 'setting',
              parent: MainHomePage.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.LoginPage]
class LoginPage extends _i7.PageRouteInfo<void> {
  const LoginPage()
      : super(
          LoginPage.name,
          path: '/',
        );

  static const String name = 'LoginPage';
}

/// generated route for
/// [_i2.MainHomePage]
class MainHomePage extends _i7.PageRouteInfo<void> {
  const MainHomePage({List<_i7.PageRouteInfo>? children})
      : super(
          MainHomePage.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'MainHomePage';
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRouter extends _i7.PageRouteInfo<HomeRouterArgs> {
  HomeRouter({_i8.Key? key})
      : super(
          HomeRouter.name,
          path: 'home',
          args: HomeRouterArgs(key: key),
        );

  static const String name = 'HomeRouter';
}

class HomeRouterArgs {
  const HomeRouterArgs({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return 'HomeRouterArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.CalendarScreen]
class CalendarRouter extends _i7.PageRouteInfo<void> {
  const CalendarRouter()
      : super(
          CalendarRouter.name,
          path: 'calendar',
        );

  static const String name = 'CalendarRouter';
}

/// generated route for
/// [_i5.RecordScreen]
class RecordRouter extends _i7.PageRouteInfo<RecordRouterArgs> {
  RecordRouter({_i8.Key? key})
      : super(
          RecordRouter.name,
          path: 'record',
          args: RecordRouterArgs(key: key),
        );

  static const String name = 'RecordRouter';
}

class RecordRouterArgs {
  const RecordRouterArgs({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return 'RecordRouterArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.SettingScreen]
class SettingRouter extends _i7.PageRouteInfo<void> {
  const SettingRouter()
      : super(
          SettingRouter.name,
          path: 'setting',
        );

  static const String name = 'SettingRouter';
}
