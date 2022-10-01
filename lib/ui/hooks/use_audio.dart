import 'package:audio_service/audio_service.dart';
import 'package:easy_audio_player/services/audio_player_service.dart';
import 'package:easy_audio_player/widgets/buttons/play_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mgtv/data/models/clip/clip.dart';
import 'package:mgtv/ui/components/audio_player/audio_player_seekbar.dart';

Widget useAudioPlayer({required AudioClip episode, required String cookie}) {
  return use(
    _AudioHook(
      cookie: cookie,
      episode: episode,
    ),
  );
}

class _AudioHook extends Hook<Widget> {
  const _AudioHook({required this.episode, required this.cookie});
  final AudioClip episode;
  final String cookie;
  @override
  _AudioHookState createState() => _AudioHookState();
}

class _AudioHookState extends HookState<Widget, _AudioHook> {
  AudioPlayerService audioPlayer = AudioPlayerService();

  @override
  void initHook() {
    super.initHook();
    audioPlayer.player.setAudioSource(
      ConcatenatingAudioSource(
        children: <AudioSource>[
          AudioSource.uri(Uri.parse(hook.episode.url),
              tag: MediaItem(
                id: hook.episode.id,
                artUri: Uri.parse(hook.episode.thumbnail),
                title: hook.episode.episodeTitle,
                artist: hook.episode.name,
                duration: audioPlayer.player.duration,
              ),
              headers: <String, String>{'cookie': hook.cookie})
        ],
      ),
    );
    audioPlayer.player.play();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
          child: Column(
        children: <Widget>[
          PlayButton(player: audioPlayer.player),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AudioPlayerSeekBar(
              audioPlayer: audioPlayer,
            ),
          )
        ],
      ));

  @override
  void dispose() {
    audioPlayer.player.stop();
    super.dispose();
  }
}
