import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
              fullScreenAspectRatio: 4 / 3,
              fit: BoxFit.cover,
              autoDetectFullscreenDeviceOrientation: true,
              deviceOrientationsAfterFullScreen: <DeviceOrientation>[
                DeviceOrientation.portraitUp
              ],
              systemOverlaysAfterFullScreen: <SystemUiOverlay>[
                SystemUiOverlay.top
              ],
              showPlaceholderUntilPlay: true,
              placeholder: CachedNetworkImage(
                imageUrl: imageUrl,
                cacheKey: videoName,
                fit: BoxFit.cover,
              ));
      BetterPlayerDataSource dataSource =
          BetterPlayerDataSource(BetterPlayerDataSourceType.network, videoUrl,
              resolutions: resolutions,
              cacheConfiguration: BetterPlayerCacheConfiguration(
                useCache: true,
                preCacheSize: 100 * 1024 * 1024,
                maxCacheSize: 100 * 1024 * 1024,
                maxCacheFileSize: 100 * 1024 * 1024,
                key: videoName,
              ),
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
