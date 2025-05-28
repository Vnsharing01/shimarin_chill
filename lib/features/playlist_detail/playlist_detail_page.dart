import 'package:flutter/material.dart';

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

class _PlaylistDetailPageState extends State<PlaylistDetailPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
