// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magazine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Magazine _$MagazineFromJson(Map<String, dynamic> json) => Magazine(
      title: json['title'] as String?,
      pid: json['pid'] as int?,
      shortTitle: json['shortTitle'] as String?,
    );

Map<String, dynamic> _$MagazineToJson(Magazine instance) => <String, dynamic>{
      'title': instance.title,
      'pid': instance.pid,
      'shortTitle': instance.shortTitle,
    };
