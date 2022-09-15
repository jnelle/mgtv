// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_data.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _FeedDataSource implements FeedDataSource {
  _FeedDataSource(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<List<MainFeed>>> getMainFeed({required cookie}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'cookie': cookie};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<HttpResponse<List<MainFeed>>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/v1/?action=getMainFeed',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => MainFeed.fromJson(i as Map<String, dynamic>))
        .toList();
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<dynamic>> getHtmlFeed({required cookie}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'cookie': cookie};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, '/u',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<GetClip>> getClip(identifier,
      {required cookie, required action}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'identifier': identifier,
      r'action': action
    };
    final _headers = <String, dynamic>{r'cookie': cookie};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<GetClip>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/v1/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetClip.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<Subscriptions>> listSubscriptions(
      {required cookie}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'cookie': cookie};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<Subscriptions>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/v1/?action=listSubscriptions',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Subscriptions.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<GetFeed> getFeed(
      {required from, required limit, required page, required cookie}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'from': from,
      r'limit': limit,
      r'page': page
    };
    final _headers = <String, dynamic>{r'cookie': cookie};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetFeed>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/v1/?action=getFeed',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetFeed.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HttpResponse<dynamic>> getMagazinePage(
      {required cookie, required magazine}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'cookie': cookie};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<HttpResponse<dynamic>>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, '/mag/${magazine}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
