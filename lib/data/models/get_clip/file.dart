import 'package:json_annotation/json_annotation.dart';

part 'file.g.dart';

@JsonSerializable()
class File {
  factory File.fromJson(Map<String, dynamic> json) => _$FileFromJson(json);

  File({
    this.size,
    this.cc,
    this.t,
    this.sizeReadable,
    this.dimensions,
    this.desc,
    this.url,
  });
  int? size;
  bool? cc;
  String? t;
  @JsonKey(name: 'size_readable')
  String? sizeReadable;
  String? dimensions;
  String? desc;
  String? url;

  Map<String, dynamic> toJson() => _$FileToJson(this);
}
