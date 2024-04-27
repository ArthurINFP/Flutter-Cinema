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
  Future<void> clearData() {
    return datasource.clearData();
  }

  @override
  Future<void> createTicket(TicketModel model) {
    return datasource.createTicket(model);
  }

  @override
  Future<bool> deleteTicket(String ticketId) {
    return datasource.deleteTicket(ticketId);
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
