// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:cinema/core/common/model/bloc_status_state.dart';

class AppState {
  BlocStatusState status;
  Locale? locale;
  AppState({
    required this.status,
    this.locale,
  });

  AppState copyWith({
    required BlocStatusState status,
    Locale? locale,
  }) {
    return AppState(status: status, locale: locale);
  }
}
