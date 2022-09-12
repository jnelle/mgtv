import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/data/models/main_feed/main_feed.dart';
import 'package:mgtv/data/remote/app_dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'feed_data.g.dart';

final Provider<FeedDataSource> feedDataProvider = Provider<FeedDataSource>(
    (ProviderRef<FeedDataSource> ref) => FeedDataSource(ref.read));

@RestApi()
abstract class FeedDataSource {
  factory FeedDataSource(Reader reader) => _FeedDataSource(reader(dioProvider));

  @GET('/api/v1/?action=getMainFeed')
  Future<HttpResponse<List<MainFeed>>> getMainFeed(
      {@Header('cookie') required String cookie});

  @GET('/u')
  Future<HttpResponse<dynamic>> getHtmlFeed(
      {@Header('cookie') required String cookie});
}
