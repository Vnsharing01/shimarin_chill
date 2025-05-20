import 'package:flutter/material.dart';

class AppTextStyle {
  static TextStyle lable({
    Color? color,
    double? size,
  }) {
    return TextStyle(
      fontSize: size ?? 20,
      fontWeight: FontWeight.w700,
      color: color,
      height: 1.2,
    );
  }

  static TextStyle title({
    Color? color,
    double? size,
  }) {
    return TextStyle(
      fontSize: size ?? 16,
      fontWeight: FontWeight.w700,
      color: color,
      height: 1.2,
    );
  }

  static TextStyle body16({
    Color? color,
    double? size,
  }) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: color,
      height: 1.2,
    );
  }

  static TextStyle body14({
    Color? color,
    double? size,
  }) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: color,
      height: 1.2,
    );
  }

  static TextStyle body12({
    Color? color,
    double? size,
  }) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: color,
      height: 1.2,
    );
  }
}
