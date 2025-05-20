import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimarin_chill/features/home/bloc/home_bloc.dart';
import 'package:shimarin_chill/features/home/home_page.dart';
import 'package:shimarin_chill/features/music_play/bloc/music_play_bloc.dart';
import 'package:shimarin_chill/features/music_play/music_play_page.dart';
import 'package:shimarin_chill/features/playlist_detail/bloc/playlist_detail_bloc.dart';
import 'package:shimarin_chill/features/playlist_detail/playlist_detail_page.dart';
import 'package:shimarin_chill/features/setting/bloc/setting_bloc.dart';
import 'package:shimarin_chill/features/setting/setting_page.dart';
import 'package:shimarin_chill/routes/router_path.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: RouterPath.home,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => HomeBloc(),
          child: const HomePage(),
        );
      },
    ),
    GoRoute(
      path: RouterPath.setting,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => SettingBloc(),
          child: const SettingPage(),
        );
      },
    ),
    GoRoute(
      path: RouterPath.playlistDetail,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => PlaylistDetailBloc(),
          child: const PlaylistDetailPage(),
        );
      },
    ),
    GoRoute(
      path: RouterPath.musicPlay,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => MusicPlayBloc(),
          child: const MusicPlayPage(),
        );
      },
    ),
  ],
);
