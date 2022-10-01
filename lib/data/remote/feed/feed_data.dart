import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/data/models/get_clip/get_clip.dart';
import 'package:mgtv/data/models/get_feed/get_feed.dart';
import 'package:mgtv/data/models/main_feed/main_feed.dart';
import 'package:mgtv/data/models/subscriptions/subscriptions.dart';
import 'package:mgtv/data/remote/app_dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feed_data.g.dart';

@riverpod
FeedDataSource feedData(Ref ref) => FeedDataSource(ref);

@RestApi()
abstract class FeedDataSource {
  factory FeedDataSource(Ref reader) =>
      _FeedDataSource(reader.read(dioProvider));

  @GET('/api/v1/?action=getMainFeed')
  Future<HttpResponse<List<MainFeed>>> getMainFeed(
      {@Header('cookie') required String cookie});

  @GET('/u')
  Future<HttpResponse<dynamic>> getHtmlFeed(
      {@Header('cookie') required String cookie});

  @GET('/api/v1/')
  Future<HttpResponse<GetClip>> getClip(
    @Query('identifier') String identifier, {
    @Header('cookie') required String cookie,
    @Query('action') required String action,
  });

  @GET('/api/v1/?action=listSubscriptions')
  Future<HttpResponse<Subscriptions>> listSubscriptions({
    @Header('cookie') required String cookie,
  });

  @GET('/api/v1/?action=getFeed')
  Future<GetFeed> getFeed({
    @Query('from') required List<String> from,
    @Query('limit') required int limit,
    @Query('page') required int page,
    @Header('cookie') required String cookie,
  });

  @GET('/mag/{magazine}')
  Future<HttpResponse<dynamic>> getMagazinePage({
    @Header('cookie') required String cookie,
    @Path('magazine') required String magazine,
  });
}
