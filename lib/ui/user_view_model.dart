import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html/dom.dart' as dom;
import 'package:mgtv/data/app_error.dart';
import 'package:mgtv/data/models/main_feed/main_feed.dart';
import 'package:mgtv/data/models/result/result.dart';
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
    for (dom.Element element in pictureIterator) {
      if (element.attributes['src']!.contains('dl.massengeschmack')) {
        picture = element.attributes['src']!;
      }
    }
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
}
