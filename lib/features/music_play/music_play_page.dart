import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimarin_chill/utils/app_text_style.dart';
import 'package:shimarin_chill/utils/paths/images_path.dart';

class MusicPlayPage extends StatefulWidget {
  const MusicPlayPage({super.key});

  @override
  State<MusicPlayPage> createState() => _MusicPlayPageState();
}

class _MusicPlayPageState extends State<MusicPlayPage> {
  @override
  void initState() {
    super.initState();
    // xoay ngang màn hình
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // xoay dọc màn hình
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(dfImg),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(top: 24),
            child: Text(
              "3:45",
              style: AppTextStyle.timeDuration(
                size: 102,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 200),
            child: LinearProgressIndicator(
              minHeight: 12,
              borderRadius: BorderRadius.circular(8),
              value: 50.0.clamp(0.0, 0.1),
              backgroundColor: Colors.grey.withOpacity(0.3),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}