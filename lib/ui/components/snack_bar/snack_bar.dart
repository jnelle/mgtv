import 'package:flutter/material.dart';
import 'package:sized_context/sized_context.dart';

void showErrorSnackbar({
  required BuildContext context,
  required String message,
}) {
  final SnackBar snackBar = SnackBar(
    content: Text(
      message,
      style: TextStyle(
        fontSize: context.widthPct(0.075),
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    ),
    margin: const EdgeInsets.only(bottom: 16, right: 8, left: 8),
    backgroundColor: Colors.red,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showSuccessSnackbar({
  required BuildContext context,
  required String message,
}) {
  final SnackBar snackBar = SnackBar(
    content: Text(
      message,
      style: TextStyle(
        fontSize: context.widthPct(0.075),
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    ),
    margin: const EdgeInsets.only(bottom: 16, right: 8, left: 8),
    backgroundColor: Colors.green,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
