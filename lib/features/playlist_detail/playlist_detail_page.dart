import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shimarin_chill/features/music_play/music_play_page.dart';
import 'package:shimarin_chill/features/playlist_detail/bloc/playlist_detail_bloc.dart';
import 'package:shimarin_chill/features/playlist_detail/components/playlist_view.dart';
import 'package:shimarin_chill/routes/router_path.dart';
import 'package:shimarin_chill/utils/app_icon.dart';
import 'package:shimarin_chill/utils/app_text_style.dart';
import 'package:shimarin_chill/utils/constants.dart';
import 'package:shimarin_chill/utils/enum/load_status.dart';
import 'package:shimarin_chill/utils/paths/images_path.dart';
import 'package:shimarin_chill/widgets/app_bar/df_appbar.dart';

import 'components/duration_timer_view.dart';

class DetailArguments {
  final String albumId;

  DetailArguments({
    required this.albumId,
  });
}

class PlaylistDetailPage extends StatefulWidget {
  const PlaylistDetailPage({
    super.key,
    this.arguments,
  });

  final DetailArguments? arguments;

  @override
  State<PlaylistDetailPage> createState() => _PlaylistDetailPageState();
}

class _PlaylistDetailPageState extends State<PlaylistDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  BannerAd? _bannerAd;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    getDataSounds();
    loadAd();
    super.initState();
  }

  Future getDataSounds() async {
    final bloc = context.read<PlaylistDetailBloc>();

    await Future(
      () => bloc.add(
        GetAlbumData(albumId: widget.arguments!.albumId),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlaylistDetailBloc, PlaylistDetailState>(
      listener: (context, state) {},
      builder: (context, state) {
        if ((state.loadStatus == LoadStatus.loading)) {
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
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Material(
              shape: const CircleBorder(),
              color: Colors.white,
              elevation: 5,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () {
                  context.push(
                    RouterPath.musicPlay,
                    extra: PlayArguments(
                      albumId: widget.arguments?.albumId ?? '',
                      durationSelected: state.timerSelected,
                      sounds: state.sounds ?? [],
                      image: state.data?.coverImage,
                    ),
                  );
                },
                child: Ink(
                  padding: const EdgeInsets.all(4),
                  child: CircleAvatar(
                    radius: 36,
                    child: Icon(
                      AppIcons.play,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),
            appBar: iconWhiteAppBar(
              context: context,
              title: state.data?.title ?? '',
              txtStyle: AppTextStyle.lable(color: Colors.white),
              onBack: () {
                context.go(RouterPath.home);
              },
            ),
            extendBodyBehindAppBar: true,
            body: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Column(
                children: [
                  _buildInfoView(state),
                  TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(
                        child: Text(
                          'Hẹn giờ',
                          style: AppTextStyle.title(),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Danh sách nhạc',
                          style: AppTextStyle.title(),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        const DurationTimerView(),
                        PlaylistView(
                          sounds: state.sounds,
                        ),
                      ],
                    ),
                  ),
                  _bannerAd == null
                      ? const SizedBox()
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
      },
    );
  }

  Widget _buildInfoView(PlaylistDetailState state) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(state.data?.coverImage ?? imgsUrl.first),
                fit: BoxFit.fill,
                opacity: 0.5,
              ),
            ),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                          ),
                        ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        state.data?.coverImage ?? imgsUrl.first,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        state.data?.description ?? "",
                        softWrap: true,
                        textAlign: TextAlign.start,
                        style: AppTextStyle.body14(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
