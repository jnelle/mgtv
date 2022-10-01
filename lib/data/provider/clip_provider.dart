import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/data/models/clip/clip.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clip_provider.g.dart';

@riverpod
AudioClip clip(ClipRef ref) => AudioClip(
      episodeTitle: '',
      id: '',
      name: '',
      thumbnail: '',
      url: '',
      duration: Duration.zero,
    );
