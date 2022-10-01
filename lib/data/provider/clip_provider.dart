import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/data/models/clip/clip.dart';

final StateProvider<AudioClip> clipProvider =
    StateProvider<AudioClip>(((_) => AudioClip(
          episodeTitle: '',
          id: '',
          name: '',
          thumbnail: '',
          url: '',
          duration: Duration.zero,
        )));
