// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cinema/core/features/ticket/domain/entities/ticket_entity.dart';

abstract class TicketState {}

class InitTicketState extends TicketState {}

class LoadingTicketState extends TicketState {}

class SuccessTicketState extends TicketState {
  TicketEntity entity;
  SuccessTicketState({
    required this.entity,
  });
}

class FailedTicketState extends TicketState {
  String message;
  FailedTicketState({
    required this.message,
  });
}
