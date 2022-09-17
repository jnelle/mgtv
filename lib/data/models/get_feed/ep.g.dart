// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ep.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ep _$EpFromJson(Map<String, dynamic> json) => Ep(
      identifier: json['identifier'] as String?,
      pid: json['pid'] as int?,
      contentType: json['contentType'] as int?,
      title: json['title'] as String?,
      pdesc: json['pdesc'] as String?,
      img: json['img'] as String?,
      desc: json['desc'] as String?,
      duration: json['duration'] as String?,
      episodeNumber: json['enum'],
      teaserFile: json['teaserFile'] as String?,
      thumbnail: json['thumbnail'] as String?,
      date: json['date'] as int?,
      canAccess: json['canAccess'] as bool?,
    );

Map<String, dynamic> _$EpToJson(Ep instance) => <String, dynamic>{
      'identifier': instance.identifier,
      'pid': instance.pid,
      'contentType': instance.contentType,
      'title': instance.title,
      'pdesc': instance.pdesc,
      'img': instance.img,
      'desc': instance.desc,
      'duration': instance.duration,
      'enum': instance.episodeNumber,
      'teaserFile': instance.teaserFile,
      'thumbnail': instance.thumbnail,
      'date': instance.date,
      'canAccess': instance.canAccess,
    };
