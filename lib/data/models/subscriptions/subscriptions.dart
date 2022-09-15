import 'package:json_annotation/json_annotation.dart';

import 'active_subscription.dart';

part 'subscriptions.g.dart';

@JsonSerializable()
class Subscriptions {
  factory Subscriptions.fromJson(Map<String, dynamic> json) {
    return _$SubscriptionsFromJson(json);
  }

  Subscriptions({this.activeSubscriptions});
  @JsonKey(name: 'active_subscriptions')
  List<ActiveSubscription>? activeSubscriptions;

  Map<String, dynamic> toJson() => _$SubscriptionsToJson(this);
}
