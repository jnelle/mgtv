import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/data/models/get_clip/get_clip.dart';
import 'package:mgtv/data/models/get_feed/get_feed.dart';
import 'package:mgtv/data/models/main_feed/main_feed.dart';
import 'package:mgtv/data/models/result/result.dart';
import 'package:mgtv/data/models/subscriptions/subscriptions.dart';
import 'package:mgtv/data/remote/feed/feed_data.dart';
import 'package:mgtv/data/repository/feed/feed_repository.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feed_repository_impl.g.dart';

@riverpod
FeedRepositoryImpl feedRepository(Ref ref) => FeedRepositoryImpl(ref);

class FeedRepositoryImpl implements FeedRepository {
  FeedRepositoryImpl(this._reader);

  final Ref _reader;
  late final FeedDataSource _feedDataSource = _reader.read(feedDataProvider);

  @override
  Future<Result<HttpResponse<List<MainFeed>>>> getMainFeed(
          {required String cookie}) =>
      Result.guardFuture(
          () async => _feedDataSource.getMainFeed(cookie: cookie));

  @override
  Future<Result<HttpResponse<dynamic>>> getHtmlFeed({required String cookie}) =>
      Result.guardFuture(() => _feedDataSource.getHtmlFeed(cookie: cookie));

  @override
  Future<Result<HttpResponse<GetClip>>> getClip({
    required String identifier,
    required String cookie,
    required String action,
  }) =>
      Result.guardFuture(() async =>
          _feedDataSource.getClip(identifier, cookie: cookie, action: action));

  @override
  Future<Result<HttpResponse<Subscriptions>>> listSubscriptions({
    required String cookie,
  }) =>
      Result.guardFuture(
        () async => _feedDataSource.listSubscriptions(cookie: cookie),
      );

  @override
  Future<Result<GetFeed>> getFeed({
    required List<String> from,
    required int limit,
    required int page,
    required String cookie,
  }) =>
      Result.guardFuture(
        () async => _feedDataSource.getFeed(
          from: from,
          limit: limit,
          page: page,
          cookie: cookie,
        ),
      );

  @override
  Future<Result<HttpResponse<dynamic>>> getMagazinePage({
    required String cookie,
    required String magazine,
  }) =>
      Result.guardFuture(
        () async =>
            _feedDataSource.getMagazinePage(cookie: cookie, magazine: magazine),
      );
}
