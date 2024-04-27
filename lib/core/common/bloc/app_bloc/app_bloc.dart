import 'dart:async';

import 'package:cinema/core/common/bloc/app_bloc/app_event.dart';
import 'package:cinema/core/common/bloc/app_bloc/app_state.dart';
import 'package:cinema/core/common/model/bloc_status_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState(status: BlocStatusState.init)) {
    on<ChangeLanguageAppEvent>(onChangeLanguageAppEvent);
  }

  FutureOr<void> onChangeLanguageAppEvent(
      ChangeLanguageAppEvent event, Emitter<AppState> emit) {
    emit(state.copyWith(status: BlocStatusState.success, locale: event.locale));
  }
}
