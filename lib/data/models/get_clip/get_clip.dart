import 'package:json_annotation/json_annotation.dart';

import 'file.dart';

part 'get_clip.g.dart';

@JsonSerializable()
class GetClip {
  factory GetClip.fromJson(Map<String, dynamic> json) {
    return _$GetClipFromJson(json);
  }

  GetClip({
    this.identifier,
    this.pid,
    this.title,
    this.pdesc,
    this.img,
    this.desc,
    this.duration,
    this.date,
    this.subscribed,
    this.teaser,
    this.files,
  });
  String? identifier;
  int? pid;
  String? title;
  String? pdesc;
  String? img;
  String? desc;
  String? duration;
  int? date;
  bool? subscribed;
  bool? teaser;
  List<File>? files;

  Map<String, dynamic> toJson() => _$GetClipToJson(this);
}
