import 'dart:async';

import 'package:cinema/core/features/login/domain/usecases/login_usecase.dart';
import 'package:cinema/core/features/login/domain/usecases/login_usecases.implement.dart';
import 'package:cinema/core/features/ticket/domain/usecases/ticket_usecases.dart';
import 'package:cinema/core/features/ticket/domain/usecases/ticket_usecases.implement.dart';
import 'package:cinema/core/features/ticket/presentation/bloc/ticket_event.dart';
import 'package:cinema/core/features/ticket/presentation/bloc/ticket_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc() : super(InitTicketState()) {
    on<GetTicketEvent>(_onGetTicketEvent);
    on<CreateTicketEvent>(_onSaveTicketEvent);
  }

  final TicketUsecases useCases = TicketUsecasesImplement();
  final LoginUsecase _loginUsecase = LoginUsecaseImplement();

  FutureOr<void> _onGetTicketEvent(
      GetTicketEvent event, Emitter<TicketState> emit) async {
    emit(LoadingTicketState());

    try {} catch (e) {
      throw Exception(e);
    }
  }

  FutureOr<void> _onSaveTicketEvent(
      CreateTicketEvent event, Emitter<TicketState> emit) async {
    emit(LoadingTicketState());
    try {
      useCases.createTicket(event.entity);
    } catch (e) {
      print(e);
    }
  }
}
