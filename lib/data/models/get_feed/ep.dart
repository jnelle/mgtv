import 'package:json_annotation/json_annotation.dart';

part 'ep.g.dart';

@JsonSerializable()
class Ep {
  factory Ep.fromJson(Map<String, dynamic> json) => _$EpFromJson(json);

  Ep({
    this.identifier,
    this.pid,
    this.contentType,
    this.title,
    this.pdesc,
    this.img,
    this.desc,
    this.duration,
    this.episodeNumber,
    this.teaserFile,
    this.thumbnail,
    this.date,
    this.canAccess,
  });
  String? identifier;
  int? pid;
  int? contentType;
  String? title;
  String? pdesc;
  String? img;
  String? desc;
  String? duration;
  @JsonKey(name: 'enum')
  dynamic episodeNumber;
  String? teaserFile;
  String? thumbnail;
  int? date;
  bool? canAccess;

  Map<String, dynamic> toJson() => _$EpToJson(this);
}
