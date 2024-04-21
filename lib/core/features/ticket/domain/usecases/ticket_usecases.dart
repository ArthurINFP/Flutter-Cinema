import 'package:cinema/core/features/ticket/domain/entities/ticket_entity.dart';

abstract class TicketUsecases {
  void createTicket(TicketEntity entity);
  void deleteTicket(String ticketId);
  Future<List<TicketEntity>> queryTickets({required String userId});
  Future<TicketEntity?> updateTicket(TicketEntity entity);
  void clearData();
  Future<TicketEntity?> queryTicket({required String ticketId});
}
