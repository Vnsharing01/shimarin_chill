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
