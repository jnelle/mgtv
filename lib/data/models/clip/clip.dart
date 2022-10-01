import 'package:freezed_annotation/freezed_annotation.dart';

part 'clip.freezed.dart';
part 'clip.g.dart';

@freezed
class AudioClip with _$AudioClip {
  factory AudioClip({
    required String episodeTitle,
    required String thumbnail,
    required String name,
    required String url,
    required String id,
    required Duration duration,
  }) = _AudioClip;

  factory AudioClip.fromJson(Map<String, Object?> json) =>
      _$AudioClipFromJson(json);
}
