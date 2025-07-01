import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimarin_chill/features/playlist_detail/playlist_detail_page.dart';
import 'package:shimarin_chill/routes/router_path.dart';
import 'package:shimarin_chill/utils/app_icon.dart';
import 'package:shimarin_chill/utils/app_text_style.dart';
import 'package:shimarin_chill/widgets/app_bar/df_appbar.dart';
import 'package:shimarin_chill/widgets/button/btn_text.dart';

class FinishArguments {
  final String albumId;

  FinishArguments({
    required this.albumId,
  });
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
        backgroundColor: Colors.orangeAccent[100],
        primary: true,
        appBar: dfAppBar(
          title: '',
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                semanticContainer: false,
                elevation: 5,
                borderOnForeground: false,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 64,
                        child: Image.asset(
                          AppIcons.completed,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Hẹn giờ kết thúc!\n Bạn có muốn tiếp tục \nvới chủ đề này không?',
                        textAlign: TextAlign.center,
                        style: AppTextStyle.lable(
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),
                      BtnText(
                        label: "Tiếp tục",
                        onTap: () {
                          context.push(
                            RouterPath.playlistDetail,
                            extra: DetailArguments(
                              albumId: arguments?.albumId ?? '',
                            ),
                          );
                        },
                      ),
                      BtnText(
                        label: "Trang chủ",
                        onTap: () {
                          context.go(RouterPath.home);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
