import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimarin_chill/features/music_play/music_play_page.dart';
import 'package:shimarin_chill/features/playlist_detail/bloc/playlist_detail_bloc.dart';
import 'package:shimarin_chill/features/playlist_detail/components/playlist_view.dart';
import 'package:shimarin_chill/routes/router_path.dart';
import 'package:shimarin_chill/utils/app_icon.dart';
import 'package:shimarin_chill/utils/app_text_style.dart';
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

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    getDataSounds();
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
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return SafeArea(
          child: Scaffold(
            appBar: iconWhiteAppBar(
              context: context,
              title: state.data?.title ?? '',
              txtStyle: AppTextStyle.lable(color: Colors.white),
            ),
            extendBodyBehindAppBar: true,
            body: Stack(
              fit: StackFit.expand,
              children: [
                MediaQuery.removePadding(
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
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: Material(
                    shape: const CircleBorder(),
                    elevation: 1.5,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        // context.push(RouterPath.musicPlay,
                        //     extra: PlayArguments(
                        //       durationSelected: state.timerSelected,
                        //       sounds: state.sounds ?? [],
                        //     ));
                        context.go(
                          RouterPath.finish,
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
                ),
              ],
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
}
