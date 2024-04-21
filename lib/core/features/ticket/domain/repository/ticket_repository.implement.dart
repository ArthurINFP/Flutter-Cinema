// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cinema/core/features/ticket/data/local/ticket_local_datasource.dart';
import 'package:cinema/core/features/ticket/data/local/ticket_local_datasource_imeplement.dart';
import 'package:cinema/core/features/ticket/data/models/ticket_model.dart';
import 'package:cinema/core/features/ticket/domain/repository/ticket_repository.dart';

class TicketRepositoryImplement extends TicketRepository {
  TicketLocalDatasource datasource;
  TicketRepositoryImplement({required this.datasource}) {
    datasource.initDB();
  }
  @override
  void clearData() {}

  @override
  void createTicket(TicketModel model) {
    datasource.createTicket(model);
  }

  @override
  void deleteTicket(String ticketId) {
    datasource.deleteTicket(ticketId);
  }

  @override
  Future<TicketModel?> queryTicket({required String ticketId}) {
    return datasource.queryTicket(ticketId: ticketId);
  }

  @override
  Future<List<TicketModel>> queryTickets({required String userId}) {
    return datasource.queryTickets(userId: userId);
  }

  @override
  Future<TicketModel?> updateTicket(TicketModel model) {
    return datasource.updateTicket(model);
  }
}
