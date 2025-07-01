import 'package:flutter/material.dart';
import 'package:shimarin_chill/utils/app_text_style.dart';

class BtnText extends StatefulWidget {
  const BtnText({
    super.key,
    required this.label,
    this.onTap,
  });

  final String label;
  final void Function()? onTap;

  @override
  State<BtnText> createState() => _BtnTextState();
}

class _BtnTextState extends State<BtnText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.orangeAccent,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: widget.onTap,
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
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                widget.label,
                style: AppTextStyle.title(
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
