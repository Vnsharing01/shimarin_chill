import 'package:flutter/material.dart';
import 'package:shimarin_chill/data/models/album_model.dart';
import 'package:shimarin_chill/utils/app_text_style.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({
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
        child: SizedBox(
          height: height ?? 81,
          width: double.infinity,
          child: Row(
            children: [
              Container(
                width: height ?? 82,
                height: height ?? 81,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    data.coverImage ?? '',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      data.title ?? '',
                      style: AppTextStyle.title(size: 20),
                    ),
                    data.selectedTime != null
                        ? const Text("data.time")
                        : const SizedBox.shrink(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
