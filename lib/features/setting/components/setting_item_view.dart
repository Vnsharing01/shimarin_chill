import 'package:flutter/material.dart';
import 'package:shimarin_chill/utils/app_text_style.dart';

class SettingItemView extends StatelessWidget {
  const SettingItemView({
    super.key,
    required this.title,
    this.icon,
    this.onTap,
  });

  final String title;
  final Widget? icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  textAlign: icon != null ? TextAlign.start : TextAlign.center,
                  style: AppTextStyle.body16().copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (icon != null) ...[
                icon ?? const SizedBox.shrink(),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
