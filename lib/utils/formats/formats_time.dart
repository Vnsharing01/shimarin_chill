 String formatDurationMMSS(Duration duration) {
    final minutes = duration.inHours.remainder(60);
    final seconds = duration.inMinutes.remainder(60);

    String twoDigits(int time) => time.toString().padLeft(2, '0');
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }