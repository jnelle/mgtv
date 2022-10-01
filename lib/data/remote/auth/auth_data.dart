import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/data/remote/app_dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_data.g.dart';

@riverpod
AuthDataSource authData(Ref ref) => AuthDataSource(ref);

@RestApi()
abstract class AuthDataSource {
  factory AuthDataSource(Ref reader) =>
      _AuthDataSource(reader.read(dioProvider));

  @POST('/index_login.php')
  @FormUrlEncoded()
  Future<HttpResponse<dynamic>> login({
    @Field() required String email,
    @Field() required String password,
  });
}
