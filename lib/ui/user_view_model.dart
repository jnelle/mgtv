import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/data/app_error.dart';
import 'package:mgtv/data/models/result/result.dart';
import 'package:mgtv/data/repository/auth_repository.dart';
import 'package:mgtv/data/repository/auth_repository_impl.dart';
import 'package:retrofit/retrofit.dart';

final ChangeNotifierProvider<UserViewModel> userViewModelProvider =
    ChangeNotifierProvider<UserViewModel>(
        (ChangeNotifierProviderRef<UserViewModel> ref) =>
            UserViewModel(ref.read));

class UserViewModel extends ChangeNotifier {
  UserViewModel(this._reader);

  final Reader _reader;

  late final AuthRepository _authRepository = _reader(authRepositoryProvider);
}

extension AuthViewModel on UserViewModel {
  Future<HttpResponse<dynamic>> login(
          {required String email, required String password}) =>
      _authRepository.login(email: email, password: password).then(
          (Result<HttpResponse<dynamic>> result) => result.when(
              success: (HttpResponse<dynamic> data) => data,
              failure: (AppError error) => throw error));
}
