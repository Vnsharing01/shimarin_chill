import 'package:flutter/material.dart';
import 'package:shimarin_chill/utils/app_text_style.dart';

PreferredSizeWidget dfAppBar({
  required String title,
  List<Widget>? actions,
}) =>
    AppBar(
      title: Text(
        title,
        style: AppTextStyle.title(),
      ),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      actions: actions,
    );
