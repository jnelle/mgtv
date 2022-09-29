import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/data/models/magazine/magazine.dart';

final StateProvider<List<Magazine>> magazinesProvider =
    StateProvider<List<Magazine>>(((_) => <Magazine>[]));
