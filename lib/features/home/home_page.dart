import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shimarin_chill/features/home/bloc/home_bloc.dart';
import 'package:shimarin_chill/features/playlist_detail/playlist_detail_page.dart';
import 'package:shimarin_chill/routes/router_path.dart';
import 'package:shimarin_chill/utils/app_icon.dart';
import 'package:shimarin_chill/utils/app_text_style.dart';
import 'package:shimarin_chill/utils/constants.dart';
import 'package:shimarin_chill/utils/enum/load_status.dart';
import 'package:shimarin_chill/utils/paths/images_path.dart';
import 'package:shimarin_chill/widgets/app_bar/df_appbar.dart';
import 'package:shimarin_chill/widgets/button/btn_icon.dart';
import 'package:shimarin_chill/widgets/card/background_album_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BannerAd? _bannerAd;
  @override
  void initState() {
    final bloc = context.read<HomeBloc>();
    // showDownloadDataPopup();
    if (bloc.state.loadStatus == LoadStatus.loading ||
        bloc.state.loadStatus == LoadStatus.initial) {
      context.read<HomeBloc>().add(AddPlaylist());
    }
    super.initState();
    loadAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (!state.isFirstDownload) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Dialog.fullscreen(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    loadingImg,
                    scale: 3,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Ứng dụng đang tải tài nguyên, \nXin vui lòng chờ một chút.',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.lable(size: 16),
                  ),
                  Text(
                    '(Tài nguyên sẽ được tải một lần duy nhất.)',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.body12(),
                  )
                ],
              ),
            ),
          );
        } else {
          if (Navigator.of(context, rootNavigator: true).canPop()) {
            Navigator.of(context, rootNavigator: true).pop();
          }
        }
      },
      builder: (context, state) {
        if ((state.loadStatus == LoadStatus.loading ||
            state.loadStatus == LoadStatus.initial)) {
          return Scaffold(
            body: Center(
              child: Image.asset(
                loadingImg,
                scale: 4,
              ),
            ),
          );
        }
        return SafeArea(
          child: Scaffold(
            appBar: dfAppBar(
              title: "Shimarin Chill",
              actions: [
                BtnIcon(
                  onTap: () {
                    context.push(RouterPath.setting);
                  },
                  icon: AppIcons.setting,
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final item = state.albums?[index];
                        return BackgroundAlbumCard(
                          height: 100,
                          data: item,
                          onTap: () {
                            context.push(
                              RouterPath.playlistDetail,
                              extra: DetailArguments(
                                albumId: item?.id ?? '',
                              ),
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 4),
                      itemCount: state.albums?.length ?? 0,
                    ),
                  ),
                  _bannerAd == null
                      ? const SizedBox(height: 24)
                      : const SizedBox.shrink(),
                  _bannerAd == null
                      ? const SizedBox()
                      : SizedBox(
                          width: _bannerAd!.size.width.toDouble(),
                          height: _bannerAd!.size.height.toDouble(),
                          child: AdWidget(ad: _bannerAd!),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Loads a banner ad.
  void loadAd() {
    final bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: adUnitTestId,
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
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );

    // Start loading.
    bannerAd.load();
  }
}
