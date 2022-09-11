import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/data/remote/app_dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'auth_data.g.dart';

final Provider<AuthDataSource> authDataProvider = Provider<AuthDataSource>(
    (ProviderRef<AuthDataSource> ref) => AuthDataSource(ref.read));

@RestApi()
abstract class AuthDataSource {
  factory AuthDataSource(Reader reader) => _AuthDataSource(reader(dioProvider));

  @POST('/index_login.php?redirect=%2F')
  @FormUrlEncoded()
  Future<HttpResponse<dynamic>> login({
    @Field() required String email,
    @Field() required String password,
  });
}
