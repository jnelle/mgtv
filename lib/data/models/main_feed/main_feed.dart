import 'package:json_annotation/json_annotation.dart';

part 'main_feed.g.dart';

@JsonSerializable()
class MainFeed {
  factory MainFeed.fromJson(Map<String, dynamic> json) {
    return _$MainFeedFromJson(json);
  }

  MainFeed({
    this.identifier,
    this.pid,
    this.contentType,
    this.title,
    this.pdesc,
    this.img,
    this.desc,
    this.duration,
    this.episodeNumber,
    this.thumbnail,
    this.teaserFile,
    this.date,
    this.subscribed,
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
  int? episodeNumber;
  String? thumbnail;
  String? teaserFile;
  int? date;
  bool? subscribed;

  Map<String, dynamic> toJson() => _$MainFeedToJson(this);
}
