import 'package:cinema/core/features/ticket/data/local/ticket_local_datasource_imeplement.dart';
import 'package:cinema/core/features/ticket/data/models/ticket_model.dart';
import 'package:cinema/core/features/ticket/domain/entities/ticket_entity.dart';
import 'package:cinema/core/features/ticket/domain/repository/ticket_repository.implement.dart';
import 'package:cinema/core/features/ticket/domain/usecases/ticket_usecases.dart';

class TicketUsecasesImplement extends TicketUsecases {
  final _repository =
      TicketRepositoryImplement(datasource: TicketLocalDatasourceImplement());
  @override
  Future<void> clearData() {
    return _repository.clearData();
  }

  @override
  Future<void> createTicket(TicketEntity entity) {
    return _repository.createTicket(TicketModel.fromEntity(entity));
  }

  @override
  Future<bool> deleteTicket(String ticketId) {
    return _repository.deleteTicket(ticketId);
  }

  @override
  Future<TicketEntity?> queryTicket({required String ticketId}) async {
    return (await _repository.queryTicket(ticketId: ticketId))?.toEntity();
  }

  @override
  Future<List<TicketEntity>> queryTickets({required String userId}) async {
    return (await _repository.queryTickets(userId: userId))
        .map((e) => e.toEntity())
        .toList();
  }

  @override
  Future<TicketEntity?> updateTicket(TicketEntity entity) async {
    return (await _repository.updateTicket(TicketModel.fromEntity(entity)))
        ?.toEntity();
  }
}
