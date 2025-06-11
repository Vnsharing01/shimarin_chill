import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimarin_chill/utils/constants.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc()
      : super(SettingState(
          isDarkMode: prefs.getBool(darkMode) ?? false,
        )) {
    on<ChangedModeApp>((event, emit) async {
      await prefs.setBool(darkMode, event.isChanged);
      emit(
        state.copyWith(
          isDarkMode: event.isChanged,
        ),
      );
    });
  }
}
