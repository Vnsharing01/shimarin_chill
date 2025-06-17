import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimarin_chill/utils/app_icon.dart';
import 'package:shimarin_chill/utils/app_text_style.dart';
import 'package:shimarin_chill/widgets/button/btn_icon.dart';

PreferredSizeWidget dfAppBar({
  required String title,
  List<Widget>? actions,
  TextStyle? txtStyle,
}) =>
    AppBar(
      title: Text(
        title,
        style: txtStyle ?? AppTextStyle.lable(),
      ),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      actions: actions,
      elevation: 0,
    );

PreferredSizeWidget iconWhiteAppBar({
  required BuildContext context,
  required String title,
  List<Widget>? actions,
  TextStyle? txtStyle,
  void Function()? onBack,
}) =>
    AppBar(
      title: Text(
        title,
        style: txtStyle ?? AppTextStyle.lable(),
      ),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      actions: actions,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      leading: context.canPop()
          ? BtnIcon(
              onTap: () {
                onBack?.call();
                context.pop();
              },
              icon: AppIcons.back,
            )
          : null,
    );
