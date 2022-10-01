import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'storage_provider.g.dart';

@riverpod
SharedPreferences sharedPref(_) =>
    throw UnimplementedError('SharedPreferenceProvider not implemented');
