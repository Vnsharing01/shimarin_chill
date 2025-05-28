import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shimarin_chill/data/locals/local_hive.dart';
import 'package:shimarin_chill/data/models/album_model.dart';
import 'package:shimarin_chill/data/models/sound_model.dart';
import 'package:shimarin_chill/features/home/bloc/home_bloc.dart';
import 'package:shimarin_chill/routes/routes.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SoundModelAdapter());
  Hive.registerAdapter(AlbumModelAdapter());

  await Hive.openBox<SoundModel>('sounds');
  await Hive.openBox<AlbumModel>('albums');

  final localHive = LocalHive();

  await localHive.initSounds();
  await localHive.initAlbums();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.orangeAccent,
          ),
          useMaterial3: true,
        ),
        routerConfig: appRouter,
      ),
    );
  }
}
