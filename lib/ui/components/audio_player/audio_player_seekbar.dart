// ignore: depend_on_referenced_packages
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:easy_audio_player/flutter_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:mgtv/gen/colors.gen.dart';

class AudioPlayerSeekBar extends StatelessWidget {
  const AudioPlayerSeekBar({Key? key, required this.audioPlayer})
      : super(key: key);
  final AudioPlayerService audioPlayer;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: audioPlayer.player.positionStream,
        builder: (BuildContext context, AsyncSnapshot<Object> snapshot) {
          if (!snapshot.hasData) return const SizedBox();
          Duration position = snapshot.data as Duration;
          return ProgressBar(
            progressBarColor: ColorName.primaryColor,
            thumbColor: ColorName.black,
            baseBarColor: ColorName.primaryColor.withOpacity(0.2),
            bufferedBarColor: ColorName.primaryColor,
            progress: position,
            buffered: audioPlayer.player.playbackEvent.bufferedPosition,
            total: audioPlayer.player.playbackEvent.duration ?? Duration.zero,
            onSeek: audioPlayer.player.seek,
          );
        });
  }
}
