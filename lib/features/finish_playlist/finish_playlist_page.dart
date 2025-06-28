import 'package:flutter/material.dart';
import 'package:shimarin_chill/utils/app_text_style.dart';
import 'package:shimarin_chill/widgets/app_bar/df_appbar.dart';
import 'package:shimarin_chill/widgets/button/btn_text.dart';

class FinishArguments {
  FinishArguments();
}

class FinishPlaylistPage extends StatelessWidget {
  const FinishPlaylistPage({
    super.key,
    this.arguments,
  });

  final FinishArguments? arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orangeAccent.shade100,
        appBar: dfAppBar(
          title: '',
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 54),
              Text(
                'Hẹn giờ kết thúc!\n Bạn có muốn tiếp tục \nvới chủ đề này không?',
                textAlign: TextAlign.center,
                style: AppTextStyle.lable(),
              ),
              const SizedBox(height: 16),
              BtnText(
                label: "Tiếp tục",
              ),
              BtnText(
                label: "Trang chủ",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
