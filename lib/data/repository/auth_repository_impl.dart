import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/data/models/result/result.dart';
import 'package:mgtv/data/remote/auth/auth_data.dart';
import 'package:mgtv/data/repository/auth_repository.dart';
import 'package:retrofit/retrofit.dart';

final Provider<AuthRepositoryImpl> authRepositoryProvider =
    Provider<AuthRepositoryImpl>(
        (ProviderRef<AuthRepositoryImpl> ref) => AuthRepositoryImpl(ref.read));

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._reader);

  final Reader _reader;
  late final AuthDataSource _authDataSource = _reader(authDataProvider);

  @override
  Future<Result<HttpResponse<dynamic>>> login(
          {required String email, required String password}) =>
      Result.guardFuture(
          () async => _authDataSource.login(email: email, password: password));
}
