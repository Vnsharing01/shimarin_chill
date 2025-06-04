import 'package:flutter/material.dart';
import 'package:shimarin_chill/utils/app_icon.dart';
import 'package:shimarin_chill/utils/app_text_style.dart';

class BtnRadio extends StatefulWidget {
  const BtnRadio({
    super.key,
    required this.selected,
    required this.value,
    this.onTap,
  });
  final int selected;
  final int value;
  final void Function(int value)? onTap;

  @override
  State<BtnRadio> createState() => _BtnRadioState();
}

class _BtnRadioState extends State<BtnRadio> {
  int thisValue = 0;
  @override
  void initState() {
    thisValue = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkResponse(
        onTap: () => widget.onTap?.call(thisValue),
        child: Ink(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Icon(
                thisValue != widget.selected
                    ? AppIcons.radioButton
                    : AppIcons.radioActive,
                color: thisValue != widget.selected
                    ? Theme.of(context).primaryColor
                    : Colors.green,
              ),
              const SizedBox(width: 8),
              Text(
                "25 phút",
                style: AppTextStyle.body16(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
