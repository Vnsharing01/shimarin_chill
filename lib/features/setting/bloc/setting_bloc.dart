import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(const SettingState()) {
    on<ChangedModeApp>((event, emit) {
      emit(
        state.copyWith(
          isDarkMode: event.isChanged,
        ),
      );
    });
  }
}
