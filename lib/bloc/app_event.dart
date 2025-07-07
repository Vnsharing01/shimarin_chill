part of 'app_bloc.dart';

abstract class AppMainEvent {
  const AppMainEvent();
}

class ChangedThemeMode extends AppMainEvent {
  final bool isChanged;

  ChangedThemeMode({
    required this.isChanged,
  });
}
