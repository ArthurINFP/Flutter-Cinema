import 'package:cinema/core/features/ticket/domain/entities/ticket_entity.dart';

abstract class TicketUsecases {
  Future<void> createTicket(TicketEntity entity);
  Future<bool> deleteTicket(String ticketId);
  Future<List<TicketEntity>> queryTickets({required String userId});
  Future<TicketEntity?> updateTicket(TicketEntity entity);
  Future<void> clearData();
  Future<TicketEntity?> queryTicket({required String ticketId});
}
