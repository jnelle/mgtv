// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainFeed _$MainFeedFromJson(Map<String, dynamic> json) => MainFeed(
      identifier: json['identifier'] as String?,
      pid: json['pid'] as int?,
      contentType: json['contentType'] as int?,
      title: json['title'] as String?,
      pdesc: json['pdesc'] as String?,
      img: json['img'] as String?,
      desc: json['desc'] as String?,
      duration: json['duration'] as String?,
      episodeNumber: json['enum'] as int?,
      thumbnail: json['thumbnail'] as String?,
      teaserFile: json['teaserFile'] as String?,
      date: json['date'] as int?,
      subscribed: json['subscribed'] as bool?,
    );

Map<String, dynamic> _$MainFeedToJson(MainFeed instance) => <String, dynamic>{
      'identifier': instance.identifier,
      'pid': instance.pid,
      'contentType': instance.contentType,
      'title': instance.title,
      'pdesc': instance.pdesc,
      'img': instance.img,
      'desc': instance.desc,
      'duration': instance.duration,
      'enum': instance.episodeNumber,
      'thumbnail': instance.thumbnail,
      'teaserFile': instance.teaserFile,
      'date': instance.date,
      'subscribed': instance.subscribed,
    };
