import 'package:mgtv/data/models/result/result.dart';
import 'package:retrofit/dio.dart';

abstract class AuthRepository {
  Future<Result<HttpResponse<dynamic>>> login(
      {required String email, required String password});
}
