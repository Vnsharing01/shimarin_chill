import 'package:flutter/material.dart';
import 'package:shimarin_chill/data/models/album_model.dart';

class BackgroundAlbumCard extends StatelessWidget {
  const BackgroundAlbumCard({
    super.key,
    this.onTap,
    this.height,
    required this.data,
  });

  final void Function()? onTap;
  final double? height;
  final AlbumModel data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        child: Container(
          height: height ?? 81,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
                image: AssetImage(data.image ?? ''),
                fit: BoxFit.fill,
                opacity: 0.5),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(data.name ?? ''),
              data.time != null ? const Text("data.time") : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
