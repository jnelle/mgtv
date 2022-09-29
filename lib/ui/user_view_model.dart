import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html/dom.dart' as dom;
import 'package:mgtv/data/app_error.dart';
import 'package:mgtv/data/models/get_clip/get_clip.dart';
import 'package:mgtv/data/models/get_feed/get_feed.dart';
import 'package:mgtv/data/models/magazine/magazine.dart';
import 'package:mgtv/data/models/main_feed/main_feed.dart';
import 'package:mgtv/data/models/result/result.dart';
import 'package:mgtv/data/models/subscriptions/active_subscription.dart';
import 'package:mgtv/data/models/subscriptions/subscriptions.dart';
import 'package:mgtv/data/provider/storage_provider.dart';
import 'package:mgtv/data/repository/auth/auth_repository.dart';
import 'package:mgtv/data/repository/auth/auth_repository_impl.dart';
import 'package:mgtv/data/repository/feed/feed_repository.dart';
import 'package:mgtv/data/repository/feed/feed_repository_impl.dart';
import 'package:mgtv/foundation/constants.dart';
import 'package:retrofit/retrofit.dart';

final ChangeNotifierProvider<UserViewModel> userViewModelProvider =
    ChangeNotifierProvider<UserViewModel>(
        (ChangeNotifierProviderRef<UserViewModel> ref) =>
            UserViewModel(ref.read));

class UserViewModel extends ChangeNotifier {
  UserViewModel(this._reader);

  final Reader _reader;

  late final AuthRepository _authRepository = _reader(authRepositoryProvider);

  late final FlutterSecureStorage _storage = _reader(storageProvider);

  late final FeedRepository _feedRepository = _reader(feedRepositoryProvider);

  String _cookie = '';

  String get cookie => _cookie;

  set setCookie(String cookie) => _cookie = cookie;

  List<Magazine> magazines = <Magazine>[];

  String _startMagazineFeed = '';

  String get startMagazineFeed => _startMagazineFeed;

  set startMagazineFeed(String magazine) {
    _startMagazineFeed = magazine;
    notifyListeners();
  }

  bool _onlyVideo = true;

  bool get onlyVideo => _onlyVideo;

  set onlyVideo(bool setVideo) {
    _onlyVideo = setVideo;
    notifyListeners();
  }
}

extension AuthViewModel on UserViewModel {
  Future<HttpResponse<dynamic>> login(
          {required String email, required String password}) =>
      _authRepository
          .login(email: email, password: password)
          .then((Result<HttpResponse<dynamic>> result) => result.when(
              success: (HttpResponse<dynamic> data) {
                String cookie = data.response.headers['set-cookie']!
                    .firstWhere(
                        (String element) => element.contains('_mgtvSession'))
                    .split(';')[0];
                _storage.write(key: Constants.of().session, value: cookie);
                _storage.write(key: Constants.of().email, value: email);
                _storage.write(key: Constants.of().password, value: password);

                setCookie = cookie;
                return data;
              },
              failure: (AppError error) => throw error));
  Future<void> refreshCookie() async {
    String? email = await _storage.read(key: Constants.of().email);
    String? password = await _storage.read(key: Constants.of().password);

    return _authRepository
        .login(email: email!, password: password!)
        .then((Result<HttpResponse<dynamic>> result) => result.when(
            success: (HttpResponse<dynamic> data) {
              String cookie = data.response.headers['set-cookie']!
                  .firstWhere(
                      (String element) => element.contains('_mgtvSession'))
                  .split(';')[0];
              _storage.write(key: Constants.of().session, value: cookie);
              setCookie = cookie;
              return;
            },
            failure: (AppError error) => throw error));
  }

  Future<bool> isLoggedIn() async {
    return await _storage.containsKey(key: Constants.of().session) &&
        await _storage.read(key: Constants.of().session) != null;
  }

  Future<String?> getCookie() async {
    String? cookie = await _storage.read(key: Constants.of().session);
    return cookie;
  }

  Future<bool> checkLogin() async {
    bool result = await isLoggedIn();

    if (result) {
      await refreshCookie();
      return true;
    }
    return false;
  }
}

extension FeedViewModel on UserViewModel {
  Future<List<MainFeed>> getMainFeed({required String cookie}) =>
      _feedRepository
          .getMainFeed(cookie: cookie)
          .then((Result<HttpResponse<List<MainFeed>>> result) => result.when(
                success: (HttpResponse<List<MainFeed>> data) => data.data,
                failure: (AppError error) => throw error,
              ));

  Future<HttpResponse<dynamic>> getHtmlFeed({required String cookie}) =>
      _feedRepository
          .getHtmlFeed(cookie: cookie)
          .then((Result<HttpResponse<dynamic>> result) => result.when(
                success: (HttpResponse<dynamic> data) => data,
                failure: (AppError error) => throw error,
              ));

  Future<String> getWebsiteHeaderPicture({required String cookie}) async {
    HttpResponse<dynamic> response = await getHtmlFeed(cookie: cookie);
    dom.Document html = dom.Document.html(response.response.data);
    Iterable<dom.Element> pictureIterator =
        html.querySelectorAll('a > img').map((dom.Element el) => el);
    String picture = pictureIterator
        .firstWhere((dom.Element element) =>
            element.attributes['src']!.contains('massengeschmack'))
        .attributes['src']!;

    return picture;
  }

  Future<List<String?>> getWebsiteHeaderTitle({required String cookie}) async {
    HttpResponse<dynamic> response = await getHtmlFeed(cookie: cookie);
    dom.Document html = dom.Document.html(response.response.data);
    String? title =
        html.querySelector('div.heading > h2:nth-child(1) > span')!.innerHtml;

    String? subTitle = html
        .querySelector('div.heading > h2.heading-black.small.pl-5.m-0 > span')!
        .innerHtml;
    return <String?>[subTitle, title];
  }

  Future<GetClip> getClip({
    required String identifier,
    required String cookie,
    required String action,
  }) =>
      _feedRepository
          .getClip(identifier: identifier, cookie: cookie, action: action)
          .then((Result<HttpResponse<GetClip>> result) => result.when(
                success: (HttpResponse<GetClip> data) => data.data,
                failure: (AppError error) => throw error,
              ));

  Future<List<Magazine>> getMagazines({required String cookie}) async {
    HttpResponse<dynamic> response = await getHtmlFeed(cookie: cookie);
    dom.Document html = dom.Document.html(response.response.data);

    List<Magazine> magazines = html
        .querySelectorAll('#mobilemagcollapse > div > a')
        .map((dom.Element e) =>
            Magazine(title: e.innerHtml, shortTitle: e.attributes['href']))
        .toList();
    Subscriptions subscriptions = await listSubscriptions(cookie: cookie);

    for (Magazine element in magazines) {
      for (ActiveSubscription sub in subscriptions.activeSubscriptions!) {
        if (sub.title!.contains(element.title!)) {
          element.pid = sub.pid;
        }
      }
    }

    return magazines;
  }

  Future<Subscriptions> listSubscriptions({required String cookie}) async =>
      _feedRepository.listSubscriptions(cookie: cookie).then(
            (Result<HttpResponse<Subscriptions>> result) => result.when(
                success: (HttpResponse<Subscriptions> data) => data.data,
                failure: (AppError error) => throw error),
          );

  Future<GetFeed> getFeed({
    required String action,
    required List<String> from,
    required int limit,
    required int page,
    required String cookie,
  }) =>
      _feedRepository
          .getFeed(from: from, limit: limit, page: page, cookie: cookie)
          .then((Result<GetFeed> result) => result.when(
                success: (GetFeed data) => data,
                failure: (AppError error) => throw error,
              ));

  Future<HttpResponse<dynamic>> getMagazinePage({
    required String cookie,
    required String magazine,
  }) =>
      _feedRepository.getMagazinePage(cookie: cookie, magazine: magazine).then(
          (Result<HttpResponse<dynamic>> result) => result.when(
              success: (HttpResponse<dynamic> data) => data,
              failure: (AppError error) => throw error));

  Future<String> getMagazineHeadPictures(
      {required String cookie, required String magazine}) async {
    HttpResponse<dynamic> response =
        await getMagazinePage(cookie: cookie, magazine: magazine);
    dom.Document html = dom.Document.html(response.response.data);

    dom.Element? magazines =
        html.querySelector('body > div.mag-header > div.right > style');
    magazines ??= html.querySelector('body > div.mag-header > div.right > img');

    // TODO: SWITCH TO REGEX SOON
    String? child = magazines?.text
        .split('url')
        .last
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll(';', '')
        .replaceAll('{', '')
        .replaceAll('}', '')
        .trim();

    if (child == null || child.isEmpty) {
      child = magazines?.attributes['src'] ?? Constants.of().defaultImage;
    }
    return child;
  }
}
