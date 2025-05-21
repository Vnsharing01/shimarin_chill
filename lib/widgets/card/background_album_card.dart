import 'package:flutter/material.dart';
import 'package:shimarin_chill/data/models/album_model.dart';
import 'package:shimarin_chill/utils/app_text_style.dart';

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
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4,
        child: Stack(
          children: [
            Container(
              height: height ?? 81,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(data.coverImage ?? ''),
                  fit: BoxFit.fill,
                  opacity: 0.5,
                ),
              ),
            ),
            Container(
              height: height ?? 81,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            Positioned.fill(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data.title ?? '',
                      style: AppTextStyle.title(
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                    data.selectedTime != null
                        ? const Text("data.time")
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
