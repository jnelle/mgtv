// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscriptions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subscriptions _$SubscriptionsFromJson(Map<String, dynamic> json) =>
    Subscriptions(
      activeSubscriptions: (json['active_subscriptions'] as List<dynamic>?)
          ?.map((e) => ActiveSubscription.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubscriptionsToJson(Subscriptions instance) =>
    <String, dynamic>{
      'active_subscriptions': instance.activeSubscriptions,
    };
