import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shimarin_chill/features/playlist_detail/playlist_detail_page.dart';
import 'package:shimarin_chill/routes/router_path.dart';
import 'package:shimarin_chill/utils/app_icon.dart';
import 'package:shimarin_chill/utils/app_text_style.dart';
import 'package:shimarin_chill/utils/paths/images_path.dart';
import 'package:shimarin_chill/widgets/app_bar/df_appbar.dart';
import 'package:shimarin_chill/widgets/button/btn_text.dart';

class FinishArguments {
  final String albumId;

  FinishArguments({
    required this.albumId,
  });
}

class FinishPlaylistPage extends StatefulWidget {
  const FinishPlaylistPage({
    super.key,
    this.arguments,
  });

  final FinishArguments? arguments;

  @override
  State<FinishPlaylistPage> createState() => _FinishPlaylistPageState();
}

class _FinishPlaylistPageState extends State<FinishPlaylistPage> {
  BannerAd? _bannerAd;
  @override
  void initState() {
    loadAd();
    super.initState();
  }

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
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(dfImg),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _bannerAd == null
                  // Nothing to render yet.
                  ? const SizedBox()
                  // The actual ad.
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: _bannerAd!.size.width.toDouble(),
                        height: _bannerAd!.size.height.toDouble(),
                        child: AdWidget(ad: _bannerAd!),
                      ),
                    ),
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
                              albumId: widget.arguments?.albumId ?? '',
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
              _bannerAd == null
                  // Nothing to render yet.
                  ? const SizedBox()
                  // The actual ad.
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: _bannerAd!.size.width.toDouble(),
                        height: _bannerAd!.size.height.toDouble(),
                        child: AdWidget(ad: _bannerAd!),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  /// Loads a banner ad.
  void loadAd() {
    final bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      request: const AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _bannerAd = ad as BannerAd;
            debugPrint('BannerAd success');
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    );

    // Start loading.
    bannerAd.load();
  }
}
