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
import 'package:mgtv/ui/pages/auth/login_screen.dart' as _i1;
import 'package:mgtv/ui/pages/home/home.dart' as _i2;
import 'package:mgtv/ui/pages/home/home_clip_page.dart' as _i3;
import 'package:mgtv/ui/pages/home/home_feed.dart' as _i4;
import 'package:mgtv/ui/pages/magazine/magazine.dart' as _i5;
import 'package:mgtv/ui/pages/settings/settings.dart' as _i6;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    Login.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.LoginScreen());
    },
    Home.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.HomeScreen());
    },
    Clip.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.ClipPage());
    },
    Feed.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.HomeFeed());
    },
    Magazine.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i5.MagazinePage());
    },
    Settingspage.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i6.SettingsPage());
    }
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(Login.name, path: '/signIn'),
        _i7.RouteConfig(Home.name, path: '/', children: [
          _i7.RouteConfig(Feed.name, path: 'feed', parent: Home.name),
          _i7.RouteConfig(Magazine.name, path: 'magazine', parent: Home.name),
          _i7.RouteConfig(Settingspage.name,
              path: 'settings', parent: Home.name)
        ]),
        _i7.RouteConfig(Clip.name, path: '/clip')
      ];
}

/// generated route for
/// [_i1.LoginScreen]
class Login extends _i7.PageRouteInfo<void> {
  const Login() : super(Login.name, path: '/signIn');

  static const String name = 'Login';
}

/// generated route for
/// [_i2.HomeScreen]
class Home extends _i7.PageRouteInfo<void> {
  const Home({List<_i7.PageRouteInfo>? children})
      : super(Home.name, path: '/', initialChildren: children);

  static const String name = 'Home';
}

/// generated route for
/// [_i3.ClipPage]
class Clip extends _i7.PageRouteInfo<void> {
  const Clip() : super(Clip.name, path: '/clip');

  static const String name = 'Clip';
}

/// generated route for
/// [_i4.HomeFeed]
class Feed extends _i7.PageRouteInfo<void> {
  const Feed() : super(Feed.name, path: 'feed');

  static const String name = 'Feed';
}

/// generated route for
/// [_i5.MagazinePage]
class Magazine extends _i7.PageRouteInfo<void> {
  const Magazine() : super(Magazine.name, path: 'magazine');

  static const String name = 'Magazine';
}

/// generated route for
/// [_i6.SettingsPage]
class Settingspage extends _i7.PageRouteInfo<void> {
  const Settingspage() : super(Settingspage.name, path: 'settings');

  static const String name = 'Settingspage';
}
