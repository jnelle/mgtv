import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/data/models/main_feed/main_feed.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'episode_provider.g.dart';

@riverpod
MainFeed episode(_) => MainFeed();
