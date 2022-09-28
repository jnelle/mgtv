import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// ignore: must_be_immutable
class VideoWidget extends HookWidget {
  VideoWidget({
    Key? key,
    required this.videoUrl,
    required this.cookie,
    required this.imageUrl,
    required this.videoName,
    required this.resolutions,
  }) : super(key: key);

  final String videoUrl;
  final String cookie;
  final String imageUrl;
  final String videoName;
  final Map<String, String> resolutions;
  late BetterPlayerController _betterPlayerController;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Map<String, String> headers = <String, String>{'cookie': cookie};
      BetterPlayerConfiguration betterPlayerConfiguration =
          BetterPlayerConfiguration(
        aspectRatio: 4 / 3,
        autoDetectFullscreenAspectRatio: true,
        autoPlay: true,
        allowedScreenSleep: false,
        fullScreenByDefault: true,
        fit: BoxFit.contain,
        autoDetectFullscreenDeviceOrientation: true,
        deviceOrientationsAfterFullScreen: <DeviceOrientation>[
          DeviceOrientation.portraitUp
        ],
        systemOverlaysAfterFullScreen: <SystemUiOverlay>[SystemUiOverlay.top],
        showPlaceholderUntilPlay: true,
        placeholder: CachedNetworkImage(
          imageUrl: imageUrl,
          cacheKey: imageUrl,
        ),
      );
      BetterPlayerDataSource dataSource =
          BetterPlayerDataSource(BetterPlayerDataSourceType.network, videoUrl,
              resolutions: resolutions,
              notificationConfiguration: BetterPlayerNotificationConfiguration(
                author: 'Massengeschmack TV',
                imageUrl: imageUrl,
                title: videoName,
                showNotification: true,
              ),
              // since I'm facing this error with video caching:
              // * thread #4, queue =
              // 'com.apple.coremedia.customurlhandlerserver.data',
              // stop reason = EXC_RESOURCE RESOURCE_TYPE_MEMORY
              //(limit=2098 MB, unused=0x0)
              // I decided to disable it for iOS
              cacheConfiguration: Platform.isAndroid
                  ? BetterPlayerCacheConfiguration(
                      useCache: true,
                      preCacheSize: 100 * 1024 * 1024,
                      maxCacheSize: 10 * 1024 * 1024,
                      maxCacheFileSize: 100 * 1024 * 1024,
                      key: videoName,
                    )
                  : null,
              headers: headers);
      _betterPlayerController =
          BetterPlayerController(betterPlayerConfiguration);

      _betterPlayerController.setupDataSource(dataSource);

      return _betterPlayerController.dispose;
    }, <Object>[videoUrl]);

    BetterPlayerController controller =
        useMemoized(() => _betterPlayerController, <Object>[videoUrl]);
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: BetterPlayer(controller: controller),
    );
  }
}
