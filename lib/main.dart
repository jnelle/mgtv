import 'package:auto_route/auto_route.dart';
import 'package:easy_audio_player/helpers/init_just_audio_background.dart';
import 'package:easy_audio_player/models/notification_configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/gen/colors.gen.dart';
import 'package:mgtv/ui/route/app_route.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initJustAudioBackground(
    NotificationSettings(
        androidNotificationChannelId: 'com.massengeschmack.tv',
        androidNotificationChannelName: 'Massengeschmack TV',
        androidNotificationOngoing: true,
        androidStopForegroundOnPause: true,
        notificationColor: ColorName.primaryColor),
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = useMemoized(() => AppRouter());

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: appRouter.defaultRouteParser(),
      routerDelegate: appRouter
          .delegate(initialRoutes: const <PageRouteInfo<dynamic>>[Login()]),
    );
  }
}
