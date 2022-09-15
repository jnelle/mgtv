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
import 'package:mgtv/data/models/main_feed/main_feed.dart' as _i8;
import 'package:mgtv/ui/pages/auth/login_screen.dart' as _i1;
import 'package:mgtv/ui/pages/home/home.dart' as _i2;
import 'package:mgtv/ui/pages/home/home_clip_page.dart' as _i3;
import 'package:mgtv/ui/pages/home/home_feed.dart' as _i4;
import 'package:mgtv/ui/pages/magazine/magazine.dart' as _i5;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    Login.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.LoginScreen());
    },
    Home.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.HomeScreen());
    },
    Clip.name: (routeData) {
      final args = routeData.argsAs<ClipArgs>();
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i3.ClipPage(
              key: args.key, mainFeedElement: args.mainFeedElement));
    },
    Feed.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.HomeFeed());
    },
    Magazine.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i5.MagazinePage());
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(Login.name, path: '/signIn'),
        _i6.RouteConfig(Home.name, path: '/', children: [
          _i6.RouteConfig(Feed.name, path: 'feed', parent: Home.name),
          _i6.RouteConfig(Magazine.name, path: 'magazine', parent: Home.name)
        ]),
        _i6.RouteConfig(Clip.name, path: '/clip')
      ];
}

/// generated route for
/// [_i1.LoginScreen]
class Login extends _i6.PageRouteInfo<void> {
  const Login() : super(Login.name, path: '/signIn');

  static const String name = 'Login';
}

/// generated route for
/// [_i2.HomeScreen]
class Home extends _i6.PageRouteInfo<void> {
  const Home({List<_i6.PageRouteInfo>? children})
      : super(Home.name, path: '/', initialChildren: children);

  static const String name = 'Home';
}

/// generated route for
/// [_i3.ClipPage]
class Clip extends _i6.PageRouteInfo<ClipArgs> {
  Clip({_i7.Key? key, required _i8.MainFeed mainFeedElement})
      : super(Clip.name,
            path: '/clip',
            args: ClipArgs(key: key, mainFeedElement: mainFeedElement));

  static const String name = 'Clip';
}

class ClipArgs {
  const ClipArgs({this.key, required this.mainFeedElement});

  final _i7.Key? key;

  final _i8.MainFeed mainFeedElement;

  @override
  String toString() {
    return 'ClipArgs{key: $key, mainFeedElement: $mainFeedElement}';
  }
}

/// generated route for
/// [_i4.HomeFeed]
class Feed extends _i6.PageRouteInfo<void> {
  const Feed() : super(Feed.name, path: 'feed');

  static const String name = 'Feed';
}

/// generated route for
/// [_i5.MagazinePage]
class Magazine extends _i6.PageRouteInfo<void> {
  const Magazine() : super(Magazine.name, path: 'magazine');

  static const String name = 'Magazine';
}
