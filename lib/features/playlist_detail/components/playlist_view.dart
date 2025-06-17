import 'package:flutter/material.dart';
import 'package:shimarin_chill/data/models/sound_model.dart';
import 'package:shimarin_chill/utils/app_icon.dart';
import 'package:shimarin_chill/utils/app_text_style.dart';
import 'package:shimarin_chill/utils/formats/formats_time.dart';

class PlaylistView extends StatefulWidget {
  const PlaylistView({
    super.key,
    this.sounds,
  });

  final List<SoundModel>? sounds;

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final item = (widget.sounds ?? [])[index];
        return _buildItemAlbumsView(
          item,
          context: context,
        );
      },
      separatorBuilder: (context, index) => const SizedBox.shrink(),
      itemCount: (widget.sounds ?? []).length,
    );
  }

  Widget _buildItemAlbumsView(
    SoundModel item, {
    required BuildContext context,
  }) {
    return ListTile(
      title: Text(
        item.title ?? '',
        style: AppTextStyle.body16().copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        formatDurationMMSS(
          Duration(minutes: item.duration ?? 0),
        ),
      ),
      leading: CircleAvatar(
        child: Icon(
          AppIcons.musicNote,
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return _buildInfoDialog(item);
          },
        );
      },
    );
  }

  Widget _buildInfoDialog(SoundModel item) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              item.title ?? '',
              softWrap: true,
              maxLines: 2,
              style: AppTextStyle.body16(),
            ),
            Text(
              formatDurationMMSS(
                Duration(milliseconds: item.duration ?? 0),
              ),
              style: AppTextStyle.body14(),
            ),
          ],
        ),
      ),
    );
  }
}
