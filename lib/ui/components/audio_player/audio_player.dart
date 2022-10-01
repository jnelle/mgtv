import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/data/models/clip/clip.dart';
import 'package:mgtv/data/provider/clip_provider.dart';
import 'package:mgtv/ui/hooks/use_audio.dart';
import 'package:mgtv/ui/user_view_model.dart';

class AudioPlayerWidget extends HookConsumerWidget {
  const AudioPlayerWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String cookie = ref.watch(
        userViewModelProvider.select((UserViewModel value) => value.cookie));
    AudioClip episode = ref.watch(clipProvider);

    return useAudioPlayer(cookie: cookie, episode: episode);
  }
}
