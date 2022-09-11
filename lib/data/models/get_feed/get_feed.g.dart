// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFeed _$GetFeedFromJson(Map<String, dynamic> json) => GetFeed(
      eps: (json['eps'] as List<dynamic>?)
          ?.map((e) => Ep.fromJson(e as Map<String, dynamic>))
          .toList(),
      pages: json['pages'] as int?,
      next: json['next'] as int?,
      prev: json['prev'] as bool?,
    );

Map<String, dynamic> _$GetFeedToJson(GetFeed instance) => <String, dynamic>{
      'eps': instance.eps,
      'pages': instance.pages,
      'next': instance.next,
      'prev': instance.prev,
    };
