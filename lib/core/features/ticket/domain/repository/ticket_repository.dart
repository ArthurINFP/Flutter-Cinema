import 'package:cinema/core/features/ticket/data/models/ticket_model.dart';

abstract class TicketRepository {
  void createTicket(TicketModel model);
  void deleteTicket(String ticketId);
  Future<List<TicketModel>> queryTickets({required String userId});
  Future<TicketModel?> updateTicket(TicketModel model);
  void clearData();
  Future<TicketModel?> queryTicket({required String ticketId});
}
