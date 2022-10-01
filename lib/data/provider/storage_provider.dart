import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Provider<SharedPreferences> sharedPrefProvider =
    Provider<SharedPreferences>(
  (_) => throw UnimplementedError('SharedPreferenceProvider not implemented'),
);
