import 'package:flutter/material.dart';
import 'package:shimarin_chill/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orangeAccent,
        ),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}
