import 'package:flutter/material.dart';
import 'package:mgtv/gen/colors.gen.dart';

InputDecoration buildInputDecoration({String? label, String? hint}) {
  return InputDecoration(
    fillColor: Colors.white,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: ColorName.submitButtonBackground,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: const BorderSide(
        color: ColorName.submitButtonBackground,
        width: 2.0,
      ),
    ),
    labelText: label,
    hintText: hint,
  );
}
