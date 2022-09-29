import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/data/models/main_feed/main_feed.dart';

final StateProvider<MainFeed> mainFeedProvider =
    StateProvider<MainFeed>(((_) => MainFeed()));
