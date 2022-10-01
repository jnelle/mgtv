import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/data/models/magazine/magazine.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'magazine_provider.g.dart';

@riverpod
List<Magazine> magazines(_) => <Magazine>[];
