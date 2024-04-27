// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cinema/core/common/model/bloc_status_state.dart';
import 'package:cinema/core/features/account/domain/entity/account_entity.dart';
import 'package:cinema/core/features/ticket/domain/entities/ticket_entity.dart';

class AccountState {
  final BlocStatusState status;
  final AccountEntity? currentEntity;
  final AccountEntity? newEntity;
  final List<TicketEntity>? ticketEntities;
  final String? message;

  AccountState({
    required this.status,
    this.currentEntity,
    this.newEntity,
    this.ticketEntities,
    this.message,
  });

  // CopyWith method
  AccountState copyWith({
    required BlocStatusState status,
    AccountEntity? currentEntity,
    AccountEntity? newEntity,
    List<TicketEntity>? ticketEntities,
    String? message,
  }) {
    return AccountState(
      status: status,
      currentEntity: currentEntity ?? this.currentEntity,
      ticketEntities: ticketEntities ?? this.ticketEntities,
      newEntity: newEntity ?? this.newEntity,
      message: message ?? this.message,
    );
  }
}
