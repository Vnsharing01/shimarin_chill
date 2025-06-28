import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimarin_chill/features/home/home_page.dart';
import 'package:shimarin_chill/routes/router_path.dart';
import 'package:shimarin_chill/utils/app_text_style.dart';

class BtnText extends StatefulWidget {
  const BtnText({
    super.key,
    required this.label,
  });

  final String label;

  @override
  State<BtnText> createState() => _BtnTextState();
}

class _BtnTextState extends State<BtnText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.orangeAccent,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: () {
            context.go(RouterPath.home);
          },
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.orangeAccent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Text(
                widget.label,
                style: AppTextStyle.title(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
