import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimarin_chill/features/home/bloc/home_bloc.dart';
import 'package:shimarin_chill/features/home/home_page.dart';
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
  ],
);
