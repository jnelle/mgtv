import 'package:auto_route/auto_route.dart';
import 'package:easy_audio_player/helpers/init_just_audio_background.dart';
import 'package:easy_audio_player/models/notification_configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/data/provider/logged_in_provider.dart';
import 'package:mgtv/data/provider/storage_provider.dart';
import 'package:mgtv/foundation/constants.dart';
import 'package:mgtv/gen/colors.gen.dart';
import 'package:mgtv/ui/route/app_route.dart';
import 'package:mgtv/ui/user_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final bool isLoggedIn =
      sharedPreferences.getKeys().contains(Constants.of().session) &&
          sharedPreferences.getString(Constants.of().session) != null;

  runApp(ProviderScope(overrides: <Override>[
    sharedPrefProvider.overrideWithValue(sharedPreferences),
    loggedInProvider.overrideWithValue(isLoggedIn),
  ], child: const MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserViewModel userViewModel = ref.read(userViewModelProvider);
    SharedPreferences sharedPref = ref.read(sharedPrefProvider);
    final AppRouter appRouter = useMemoized(() => AppRouter());
    final bool isLoggedIn = ref.watch(loggedInProvider);
    ValueNotifier<bool> isLoading = useState(true);

    useEffect(() {
      if (isLoggedIn) {
        Future<void>.microtask(() async {
          userViewModel.cookie = sharedPref.getString(Constants.of().session)!;
          await userViewModel
              .refreshCookie()
              .then((_) => isLoading.value = false);
        });
      } else {
        isLoading.value = false;
      }

      return () {};
    }, <Object>[userViewModel, isLoggedIn]);

    return isLoading.value
        ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
                child: CircularProgressIndicator(
              color: ColorName.primaryColor,
            )),
          )
        : MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: ColorName.primaryColor,
            ),
            routeInformationParser: appRouter.defaultRouteParser(),
            routerDelegate: appRouter.delegate(
                initialRoutes: isLoggedIn
                    ? const <PageRouteInfo<dynamic>>[Home()]
                    : const <PageRouteInfo<dynamic>>[Login()]),
          );
  }
}
