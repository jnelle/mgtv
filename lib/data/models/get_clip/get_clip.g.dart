// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_clip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetClip _$GetClipFromJson(Map<String, dynamic> json) => GetClip(
      identifier: json['identifier'] as String?,
      pid: json['pid'] as int?,
      title: json['title'] as String?,
      pdesc: json['pdesc'] as String?,
      img: json['img'] as String?,
      desc: json['desc'] as String?,
      duration: json['duration'] as String?,
      date: json['date'] as int?,
      subscribed: json['subscribed'] as bool?,
      teaser: json['teaser'],
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => File.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetClipToJson(GetClip instance) => <String, dynamic>{
      'identifier': instance.identifier,
      'pid': instance.pid,
      'title': instance.title,
      'pdesc': instance.pdesc,
      'img': instance.img,
      'desc': instance.desc,
      'duration': instance.duration,
      'date': instance.date,
      'subscribed': instance.subscribed,
      'teaser': instance.teaser,
      'files': instance.files,
    };
