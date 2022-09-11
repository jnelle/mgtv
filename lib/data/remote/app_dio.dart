import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/foundation/constants.dart';
import 'package:ua_client_hints/ua_client_hints.dart';

final Provider<Dio> dioProvider =
    Provider<Dio>((_) => AppDio(Constants.of().endpoint).getInstance());

class AppDio with DioMixin implements Dio {
  AppDio._(this.baseUrl, [BaseOptions? options]) {
    options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 30000,
      sendTimeout: 30000,
      receiveTimeout: 30000,
    );

    this.options = options;
    interceptors.add(InterceptorsWrapper(onRequest:
        (RequestOptions options, RequestInterceptorHandler handler) async {
      Map<String, String> headers = await userAgentClientHintsHeader();
      options.headers.addAll(headers);
      handler.next(options);
    }));

    if (kDebugMode) {
      // Local Log
      interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    }

    httpClientAdapter = DefaultHttpClientAdapter();
  }
  AppDio(this.baseUrl);

  final String baseUrl;

  Dio getInstance() => AppDio._(baseUrl);
}
