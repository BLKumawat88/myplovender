import 'package:flutter/material.dart';

class AuthCommonTheme {
  static OutlineInputBorder enabledBorder = const OutlineInputBorder(
    borderSide: BorderSide(
      width: 1,
      color: Color(0xFFDEEEF7),
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(22),
    ),
  );

  static OutlineInputBorder errorBorder = const OutlineInputBorder(
    borderSide: BorderSide(
      width: 1,
      color: Colors.red,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(22),
    ),
  );

  static OutlineInputBorder border = const OutlineInputBorder(
    borderSide: BorderSide(
      width: 1,
      color: Colors.red,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(22),
    ),
  );
}
