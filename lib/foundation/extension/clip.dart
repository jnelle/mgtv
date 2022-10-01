import 'package:mgtv/data/models/clip/clip.dart';
import 'package:mgtv/data/models/get_clip/get_clip.dart';

extension ToAudioClip on GetClip {
  AudioClip toAudioClip(String url) {
    DateTime date = DateTime.parse('2000-01-01 ${duration!}');
    Duration newDuration = Duration(
      hours: date.hour,
      minutes: date.minute,
      seconds: date.second,
    );
    return AudioClip(
      episodeTitle: title!,
      thumbnail: img!,
      name: pdesc!,
      url: url,
      id: identifier!,
      duration: newDuration,
    );
  }
}
