import 'package:json_annotation/json_annotation.dart';

part 'active_subscription.g.dart';

@JsonSerializable()
class ActiveSubscription {
  factory ActiveSubscription.fromJson(Map<String, dynamic> json) {
    return _$ActiveSubscriptionFromJson(json);
  }

  ActiveSubscription({this.title, this.pid});
  String? title;
  int? pid;

  Map<String, dynamic> toJson() => _$ActiveSubscriptionToJson(this);
}
