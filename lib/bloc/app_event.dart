part of 'app_bloc.dart';

abstract class AppEvent {
  const AppEvent();
}

class ChangedThemeMode extends AppEvent{
  final bool isChanged;

  ChangedThemeMode({
    required this.isChanged,
  });
}
