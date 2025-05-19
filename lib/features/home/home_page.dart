import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimarin_chill/data/models/album_model.dart';
import 'package:shimarin_chill/features/home/bloc/home_bloc.dart';
import 'package:shimarin_chill/routes/router_path.dart';
import 'package:shimarin_chill/utils/app_icon.dart';
import 'package:shimarin_chill/utils/app_text_style.dart';
import 'package:shimarin_chill/widgets/button/btn_icon.dart';
import 'package:shimarin_chill/widgets/card/album_card.dart';
import 'package:shimarin_chill/widgets/card/background_album_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text(
              "Home",
              style: AppTextStyle.title(),
            ),
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
                  const Text(
                    "Gần đây",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  AlbumCard(
                    data: AlbumModel(
                      image: 'assets/images/miku_study.jpg',
                      name: 'Học tập',
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Chủ Đề",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      // physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return BackgroundAlbumCard(
                          height: 100,
                          data: AlbumModel(
                            image: 'assets/images/miku_study.jpg',
                            name: 'Học tập',
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 4),
                      itemCount: 3,
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
