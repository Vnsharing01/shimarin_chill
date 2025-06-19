enum PlayDurationEnum {
  none(
    title: "Không hẹn giờ",
    key: 0,
    durationValue: 0,
  ),
  minutes25(
    title: "25 phút",
    key: 1,
    durationValue: 25,
  ),
  minutes35(
    title: "35 phút",
    key: 2,
    durationValue: 35,
  ),
  minutes45(
    title: "45 phút",
    key: 3,
    durationValue: 45,
  );

  final String title;
  final int key;
  final int durationValue;

  const PlayDurationEnum({
    required this.title,
    required this.key,
    required this.durationValue,
  });
}

extension DurationEnumExtension on PlayDurationEnum {
  static PlayDurationEnum fromKey(int key) {
    switch (key) {
      case 1:
        return PlayDurationEnum.minutes25;
      case 2:
        return PlayDurationEnum.minutes35;
      case 3:
        return PlayDurationEnum.minutes45;
      default:
        return PlayDurationEnum.none;
    }
  }

  static int getMinutes(int key) {
    switch (key) {
      case 1:
        return PlayDurationEnum.minutes25.durationValue;
      case 2:
        return PlayDurationEnum.minutes35.durationValue;
      case 3:
        return PlayDurationEnum.minutes45.durationValue;
      default:
        return PlayDurationEnum.none.durationValue;
    }
  }
}
