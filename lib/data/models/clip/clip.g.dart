// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AudioClip _$$_AudioClipFromJson(Map<String, dynamic> json) => _$_AudioClip(
      episodeTitle: json['episodeTitle'] as String,
      thumbnail: json['thumbnail'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
      id: json['id'] as String,
      duration: Duration(microseconds: json['duration'] as int),
    );

Map<String, dynamic> _$$_AudioClipToJson(_$_AudioClip instance) =>
    <String, dynamic>{
      'episodeTitle': instance.episodeTitle,
      'thumbnail': instance.thumbnail,
      'name': instance.name,
      'url': instance.url,
      'id': instance.id,
      'duration': instance.duration.inMicroseconds,
    };
