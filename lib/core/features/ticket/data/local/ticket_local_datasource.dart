import 'package:cinema/core/features/ticket/data/models/ticket_model.dart';

abstract class TicketLocalDatasource {
  void initDB();
  Future<void> createTicket(TicketModel model);
  Future<bool> deleteTicket(String ticketId);
  Future<List<TicketModel>> queryTickets({required String userId});
  Future<TicketModel?> updateTicket(TicketModel model);
  Future<void> clearData();
  Future<TicketModel?> queryTicket({required String ticketId});
}
