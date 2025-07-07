import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimarin_chill/bloc/app_bloc.dart';
import 'package:shimarin_chill/data/locals/local_hive.dart';
import 'package:shimarin_chill/data/models/album_model.dart';
import 'package:shimarin_chill/data/models/sound_model.dart';
import 'package:shimarin_chill/features/home/bloc/home_bloc.dart';
import 'package:shimarin_chill/features/setting/bloc/setting_bloc.dart';
import 'package:shimarin_chill/firebase_options.dart';
import 'package:shimarin_chill/routes/routes.dart';
import 'package:shimarin_chill/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();

  getIt.registerSingleton<SharedPreferences>(prefs);

  await Hive.initFlutter();
  Hive.registerAdapter(SoundModelAdapter());
  Hive.registerAdapter(AlbumModelAdapter());

  await Hive.openBox<SoundModel>('sounds');
  await Hive.openBox<AlbumModel>('albums');

  final localHive = LocalHive();

  await localHive.initSounds();
  await localHive.initAlbums();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppMainBloc(),
        ),
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => SettingBloc(),
        )
      ],
      child: BlocBuilder<AppMainBloc, AppMainState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Shimarin Chill',
            debugShowCheckedModeBanner: false,
            darkTheme: ThemeData.dark(),
            themeMode:
                state.isDarkMode ?? false ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent,
                scrolledUnderElevation: 0,
              ),
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.orangeAccent,
              ),
              primaryColor: Colors.orangeAccent,
              useMaterial3: true,
            ),
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
