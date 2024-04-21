// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cinema/core/features/ticket/domain/entities/ticket_entity.dart';

abstract class TicketEvent {}

class GetTicketEvent extends TicketEvent {
  String ticketId;
  GetTicketEvent({
    required this.ticketId,
  });
}

class CreateTicketEvent extends TicketEvent {
  TicketEntity entity;
  CreateTicketEvent({
    required this.entity,
  });
}
