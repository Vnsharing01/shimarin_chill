import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimarin_chill/features/home/bloc/home_bloc.dart';
import 'package:shimarin_chill/features/playlist_detail/playlist_detail_page.dart';
import 'package:shimarin_chill/routes/router_path.dart';
import 'package:shimarin_chill/utils/app_icon.dart';
import 'package:shimarin_chill/utils/app_text_style.dart';
import 'package:shimarin_chill/utils/enum/load_status.dart';
import 'package:shimarin_chill/widgets/button/btn_icon.dart';
import 'package:shimarin_chill/widgets/card/background_album_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final bloc = context.read<HomeBloc>();
    if (bloc.state.loadStatus == LoadStatus.loading ||
        bloc.state.loadStatus == LoadStatus.initial) {
      context.read<HomeBloc>().add(AddPlaylist());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
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
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text(
              "Shimarin Chill",
              style: AppTextStyle.title(),
            ),
            backgroundColor: Colors.yellow,
            centerTitle: true,
            actions: [
              BtnIcon(
                onTap: () {
                  context.push(RouterPath.setting);
                },
                icon: AppIcons.setting,
              )
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final item = state.albums?[index];
                        return BackgroundAlbumCard(
                          height: 100,
                          data: item,
                          onTap: () {
                            context.push(RouterPath.playlistDetail,
                                extra: DetailArguments(
                                  albumId: item?.id ?? '',
                                ));
                          },
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 4),
                      itemCount: state.albums?.length ?? 0,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
