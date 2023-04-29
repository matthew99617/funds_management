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
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../screen/calendar/calendar_screen.dart' as _i3;
import '../screen/home/home_screen.dart' as _i2;
import '../screen/main_home_page.dart' as _i1;
import '../screen/record/record_screen.dart' as _i4;
import '../screen/setting/setting_screen.dart' as _i5;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    MainHomeRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.MainHomePage(),
      );
    },
    HomeRouter.name: (routeData) {
      final args = routeData.argsAs<HomeRouterArgs>(
          orElse: () => const HomeRouterArgs());
      return _i6.CustomPage<dynamic>(
        routeData: routeData,
        child: _i2.HomeScreen(key: args.key),
        opaque: true,
        barrierDismissible: false,
      );
    },
    CalendarRouter.name: (routeData) {
      final args = routeData.argsAs<CalendarRouterArgs>(
          orElse: () => const CalendarRouterArgs());
      return _i6.CustomPage<dynamic>(
        routeData: routeData,
        child: _i3.CalendarScreen(key: args.key),
        opaque: true,
        barrierDismissible: false,
      );
    },
    RecordRouter.name: (routeData) {
      final args = routeData.argsAs<RecordRouterArgs>(
          orElse: () => const RecordRouterArgs());
      return _i6.CustomPage<dynamic>(
        routeData: routeData,
        child: _i4.RecordScreen(key: args.key),
        opaque: true,
        barrierDismissible: false,
      );
    },
    SettingRouter.name: (routeData) {
      return _i6.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.SettingScreen(),
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          MainHomeRoute.name,
          path: '/',
          children: [
            _i6.RouteConfig(
              HomeRouter.name,
              path: 'home',
              parent: MainHomeRoute.name,
            ),
            _i6.RouteConfig(
              CalendarRouter.name,
              path: 'calendar',
              parent: MainHomeRoute.name,
            ),
            _i6.RouteConfig(
              RecordRouter.name,
              path: 'record',
              parent: MainHomeRoute.name,
            ),
            _i6.RouteConfig(
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
class MainHomeRoute extends _i6.PageRouteInfo<void> {
  const MainHomeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          MainHomeRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'MainHomeRoute';
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRouter extends _i6.PageRouteInfo<HomeRouterArgs> {
  HomeRouter({_i7.Key? key})
      : super(
          HomeRouter.name,
          path: 'home',
          args: HomeRouterArgs(key: key),
        );

  static const String name = 'HomeRouter';
}

class HomeRouterArgs {
  const HomeRouterArgs({this.key});

  final _i7.Key? key;

  @override
  String toString() {
    return 'HomeRouterArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.CalendarScreen]
class CalendarRouter extends _i6.PageRouteInfo<CalendarRouterArgs> {
  CalendarRouter({_i7.Key? key})
      : super(
          CalendarRouter.name,
          path: 'calendar',
          args: CalendarRouterArgs(key: key),
        );

  static const String name = 'CalendarRouter';
}

class CalendarRouterArgs {
  const CalendarRouterArgs({this.key});

  final _i7.Key? key;

  @override
  String toString() {
    return 'CalendarRouterArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.RecordScreen]
class RecordRouter extends _i6.PageRouteInfo<RecordRouterArgs> {
  RecordRouter({_i7.Key? key})
      : super(
          RecordRouter.name,
          path: 'record',
          args: RecordRouterArgs(key: key),
        );

  static const String name = 'RecordRouter';
}

class RecordRouterArgs {
  const RecordRouterArgs({this.key});

  final _i7.Key? key;

  @override
  String toString() {
    return 'RecordRouterArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.SettingScreen]
class SettingRouter extends _i6.PageRouteInfo<void> {
  const SettingRouter()
      : super(
          SettingRouter.name,
          path: 'setting',
        );

  static const String name = 'SettingRouter';
}
