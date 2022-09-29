import 'package:auto_route/auto_route.dart';
import 'package:mgtv/ui/pages/auth/login_screen.dart';
import 'package:mgtv/ui/pages/home/home.dart';
import 'package:mgtv/ui/pages/home/home_clip_page.dart';
import 'package:mgtv/ui/pages/home/home_feed.dart';
import 'package:mgtv/ui/pages/magazine/magazine.dart';
import 'package:mgtv/ui/pages/settings/settings.dart';

export 'app_route.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/signIn',
      name: 'login',
      page: LoginScreen,
      initial: true,
    ),
    AutoRoute(
        path: '/',
        name: 'home',
        page: HomeScreen,
        initial: true,
        children: <AutoRoute<dynamic>>[
          AutoRoute(
            path: 'feed',
            name: 'feed',
            page: HomeFeed,
          ),
          AutoRoute(
            path: 'magazine',
            name: 'magazine',
            page: MagazinePage,
          ),
          AutoRoute(
            path: 'settings',
            name: 'settingspage',
            page: SettingsPage,
          ),
        ]),
    AutoRoute(
      path: '/clip',
      name: 'clip',
      page: ClipPage,
    ),
  ],
)
class $AppRouter {}
