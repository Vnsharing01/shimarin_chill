import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimarin_chill/data/models/sound_model.dart';
import 'package:shimarin_chill/features/playlist_detail/bloc/playlist_detail_bloc.dart';
import 'package:shimarin_chill/utils/app_icon.dart';
import 'package:shimarin_chill/utils/app_text_style.dart';
import 'package:shimarin_chill/utils/enum/load_status.dart';
import 'package:shimarin_chill/utils/paths/images_path.dart';
import 'package:shimarin_chill/widgets/app_bar/df_appbar.dart';

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
        if ((state.loadStatus == LoadStatus.loading ||
            state.loadStatus == LoadStatus.initial)) {
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
              txtStyle: AppTextStyle.title(color: Colors.white),
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
                        tabs: const [
                          Tab(
                            text: 'hẹn giờ',
                          ),
                          Tab(
                            text: 'danh sách nhạc',
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            Center(
                              child: Text('Hẹn giờ'),
                            ),
                            SizedBox(
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  final item = (state.sounds ?? [])[index];
                                  return _buildItemAlbumsView(
                                    item,
                                    context: context,
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox.shrink(),
                                itemCount: (state.sounds ?? []).length,
                              ),
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
                  child: InkWell(
                    onTap: () {
                      // chuyển màn play nhạc
                    },
                    child: CircleAvatar(
                      radius: 36,
                      child: Icon(
                        AppIcons.play,
                        size: 32,
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

  Widget _buildInfoDialog(SoundModel item) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              item.title ?? '',
              softWrap: true,
              maxLines: 2,
            ),
            Text(
              Duration(
                minutes: item.duration ?? 0,
              ).toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemAlbumsView(
    SoundModel item, {
    required BuildContext context,
  }) {
    return ListTile(
      title: Text(item.title ?? ''),
      subtitle: Text(
        Duration(minutes: item.duration ?? 0).toString(),
      ),
      leading: CircleAvatar(
        child: Icon(
          AppIcons.musicNote,
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return _buildInfoDialog(item);
          },
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
