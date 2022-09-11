import 'package:json_annotation/json_annotation.dart';

import 'ep.dart';

part 'get_feed.g.dart';

@JsonSerializable()
class GetFeed {
  factory GetFeed.fromJson(Map<String, dynamic> json) {
    return _$GetFeedFromJson(json);
  }

  GetFeed({this.eps, this.pages, this.next, this.prev});
  List<Ep>? eps;
  int? pages;
  int? next;
  bool? prev;

  Map<String, dynamic> toJson() => _$GetFeedToJson(this);
}
