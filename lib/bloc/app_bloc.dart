
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimarin_chill/utils/constants.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppMainBloc extends Bloc<AppMainEvent, AppMainState> {

  AppMainBloc() : super(AppMainState(isDarkMode: prefs.getBool(darkMode))) {
    on<ChangedThemeMode>((event, emit) {
      emit(state.copyWith(isDarkMode: event.isChanged));
    });
  }
}
