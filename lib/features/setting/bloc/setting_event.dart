part of 'setting_bloc.dart';

abstract class SettingEvent {}

class ChangedModeApp extends SettingEvent{
  final bool isChanged;

  ChangedModeApp({
    required this.isChanged,
  });
}
