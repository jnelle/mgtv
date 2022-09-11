// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

File _$FileFromJson(Map<String, dynamic> json) => File(
      size: json['size'] as int?,
      cc: json['cc'] as bool?,
      t: json['t'] as String?,
      sizeReadable: json['size_readable'] as String?,
      dimensions: json['dimensions'] as String?,
      desc: json['desc'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$FileToJson(File instance) => <String, dynamic>{
      'size': instance.size,
      'cc': instance.cc,
      't': instance.t,
      'size_readable': instance.sizeReadable,
      'dimensions': instance.dimensions,
      'desc': instance.desc,
      'url': instance.url,
    };
