part of 'setting_bloc.dart';

class SettingState extends Equatable {
  final bool isDarkMode;

  const SettingState({
    this.isDarkMode = false,
  });

  SettingState copyWith({bool? isDarkMode}) {
    return SettingState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  @override
  List<Object?> get props => [
        isDarkMode,
      ];
}