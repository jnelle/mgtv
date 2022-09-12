import 'package:mgtv/data/models/main_feed/main_feed.dart';
import 'package:mgtv/data/models/result/result.dart';
import 'package:retrofit/dio.dart';

abstract class FeedRepository {
  Future<Result<HttpResponse<List<MainFeed>>>> getMainFeed(
      {required String cookie});

  Future<Result<HttpResponse<dynamic>>> getHtmlFeed({required String cookie});
}
