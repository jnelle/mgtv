import 'package:json_annotation/json_annotation.dart';

part 'magazine.g.dart';

@JsonSerializable()
class Magazine {
  factory Magazine.fromJson(Map<String, dynamic> json) {
    return _$MagazineFromJson(json);
  }

  Magazine({this.title, this.pid, this.shortTitle});
  String? title;
  int? pid;
  String? shortTitle;

  Map<String, dynamic> toJson() => _$MagazineToJson(this);
}
