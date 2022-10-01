import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/data/models/result/result.dart';
import 'package:mgtv/data/remote/auth/auth_data.dart';
import 'package:mgtv/data/repository/auth/auth_repository.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_impl.g.dart';

@riverpod
AuthRepositoryImpl authRepository(Ref ref) => AuthRepositoryImpl(ref);

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._reader);

  final Ref _reader;
  late final AuthDataSource _authDataSource = _reader.read(authDataProvider);

  @override
  Future<Result<HttpResponse<dynamic>>> login(
          {required String email, required String password}) =>
      Result.guardFuture(
          () async => _authDataSource.login(email: email, password: password));
}
