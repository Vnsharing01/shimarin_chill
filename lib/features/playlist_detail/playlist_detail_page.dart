import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimarin_chill/features/playlist_detail/bloc/playlist_detail_bloc.dart';
import 'package:shimarin_chill/utils/app_text_style.dart';
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
  void initState() async {
    final bloc = context.read<PlaylistDetailBloc>();
    _tabController = TabController(length: 2, vsync: this);
    bloc.add(GetAlbumData(albumId: widget.arguments!.albumId));
    await Future(
      () {
        if (bloc.state.data != null &&
            (bloc.state.data?.soundIds ?? []).isNotEmpty) {
          bloc.add(GetListSounds(soundIds: bloc.state.data?.soundIds ?? []));
        }
      },
    );
    super.initState();
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
        return Scaffold(
          appBar: dfAppBar(title: 'Chill Detail'),
          body: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Stack(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(imgsUrl.first),
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
                                  imgsUrl.first,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Hãy bật playlist này khi bạn cần tập trung làm việc hoặc học bài. Bạn sẽ bất giác gật gù theo điệu nhạc đấy. Những giai điệu hip hop đầy cảm xúc này vừa giúp bạn tập trung, vừa thêm chút groove tinh tế.",
                                  softWrap: true,
                                  style: AppTextStyle.body14(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
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
                SizedBox(
                  height: 525,
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      Center(child: Text("Chill")),
                      Center(child: Text("Focus")),
                    ],
                  ),
                )
              ],
            ),
          )),
        );
      },
    );
  }
}
