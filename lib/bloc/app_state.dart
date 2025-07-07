part of 'app_bloc.dart';

class AppMainState extends Equatable {
  final bool? isDarkMode;

  const AppMainState({
    this.isDarkMode = false,
  });

  AppMainState copyWith({bool? isDarkMode}) {
    return AppMainState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  @override
  List<Object?> get props => [
        isDarkMode,
      ];
}
