// ignore_for_file: lines_longer_than_80_chars

import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/foundation/constants.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:system_info/system_info.dart';
import 'package:ua_client_hints/ua_client_hints.dart';

part 'app_dio.g.dart';

@riverpod
Dio dio(_) => AppDio(Constants.of().httpBaseUri).getInstance();

class AppDio with DioMixin implements Dio {
  AppDio._(this.baseUrl, [BaseOptions? options]) {
    options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 30000,
        sendTimeout: 30000,
        receiveTimeout: 30000,
        followRedirects: false,
        validateStatus: (int? status) {
          return status! < 303;
        });

    this.options = options;
    interceptors.add(InterceptorsWrapper(onRequest:
        (RequestOptions options, RequestInterceptorHandler handler) async {
      if (Platform.isAndroid || Platform.isIOS) {
        Map<String, String> headers = await userAgentClientHintsHeader();
        options.headers.addAll(headers);
      } else {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        Map<String, String> headers = <String, String>{
          'User-Agent':
              '${packageInfo.appName}/${packageInfo.version} (${Platform.operatingSystem}/${Platform.operatingSystemVersion})',
          'Sec-CH-UA-Arch': SysInfo.kernelArchitecture,
          'Sec-CH-UA-Model': SysInfo.operatingSystemName,
          'Sec-CH-UA-Platform-Version': Platform.operatingSystemVersion,
          'Sec-CH-UA': '"mgtv"; v="${packageInfo.version}"',
          'Sec-CH-UA-Full-Version':
              '${packageInfo.version} Buildversion: ${packageInfo.buildNumber} ${packageInfo.buildSignature}',
        };
        options.headers.addAll(headers);
      }
      handler.next(options);
    }));

    if (kDebugMode) {
      // Local Log
      interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    }
    interceptors.add(EncodingInterceptor());
    httpClientAdapter = DefaultHttpClientAdapter();
  }
  AppDio(this.baseUrl);

  final String baseUrl;

  Dio getInstance() => AppDio._(baseUrl);
}

class EncodingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.queryParameters.isEmpty) {
      super.onRequest(options, handler);
      return;
    }

    final String queryParams = _getQueryParams(options.queryParameters);
    handler.next(
      options.copyWith(
        path: _getNormalizedUrl(options.path, queryParams),
        queryParameters: Map<String, dynamic>.from(<String, dynamic>{}),
      ),
    );
  }

  String _getNormalizedUrl(String baseUrl, String queryParams) {
    if (baseUrl.contains('?')) {
      return '$baseUrl&$queryParams';
    } else {
      return '$baseUrl?$queryParams';
    }
  }

  String _getQueryParams(Map<String, dynamic> map) {
    String result = '';
    map.forEach((String key, dynamic value) {
      result += '$key=${Uri.decodeComponent(value.toString())}&';
    });
    return result;
  }
}
