enum SoundTagEnum {
  chill(
    title: "CHILL",
    key: 'chill',
  ),
  study(
    title: "STUDY",
    key: 'study',
  ),
  anime(
    title: "ANIME",
    key: 'anime',
  ),
  coffee(
    title: "COFFEE  ",
    key: 'coffee',
  );

  final String title;
  final String key;

  const SoundTagEnum({
    required this.title,
    required this.key,
  });
}
