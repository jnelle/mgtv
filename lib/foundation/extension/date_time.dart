// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String formatHHmm() {
    return DateFormat('HH:mm:ss', 'de').format(this);
  }
}
