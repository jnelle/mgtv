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
import 'package:mgtv/ui/pages/auth/login_screen.dart' as _i1;
import 'package:mgtv/ui/pages/home/home.dart' as _i2;
import 'package:mgtv/ui/pages/home/home_feed.dart' as _i3;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    Login.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.LoginScreen());
    },
    Home.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.HomeScreen());
    },
    Feed.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.HomeFeed());
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(Login.name, path: '/signIn'),
        _i4.RouteConfig(Home.name, path: '/', children: [
          _i4.RouteConfig(Feed.name, path: 'feed', parent: Home.name)
        ])
      ];
}

/// generated route for
/// [_i1.LoginScreen]
class Login extends _i4.PageRouteInfo<void> {
  const Login() : super(Login.name, path: '/signIn');

  static const String name = 'Login';
}

/// generated route for
/// [_i2.HomeScreen]
class Home extends _i4.PageRouteInfo<void> {
  const Home({List<_i4.PageRouteInfo>? children})
      : super(Home.name, path: '/', initialChildren: children);

  static const String name = 'Home';
}

/// generated route for
/// [_i3.HomeFeed]
class Feed extends _i4.PageRouteInfo<void> {
  const Feed() : super(Feed.name, path: 'feed');

  static const String name = 'Feed';
}
