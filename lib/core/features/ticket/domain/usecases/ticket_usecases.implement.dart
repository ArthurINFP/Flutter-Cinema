import 'package:cinema/core/features/ticket/data/local/ticket_local_datasource_imeplement.dart';
import 'package:cinema/core/features/ticket/data/models/ticket_model.dart';
import 'package:cinema/core/features/ticket/domain/entities/ticket_entity.dart';
import 'package:cinema/core/features/ticket/domain/repository/ticket_repository.implement.dart';
import 'package:cinema/core/features/ticket/domain/usecases/ticket_usecases.dart';

class TicketUsecasesImplement extends TicketUsecases {
  final repository =
      TicketRepositoryImplement(datasource: TicketLocalDatasourceImplement());
  @override
  void clearData() {
    repository.clearData();
  }

  @override
  void createTicket(TicketEntity entity) {
    repository.createTicket(TicketModel.fromEntity(entity));
  }

  @override
  void deleteTicket(String ticketId) {}

  @override
  Future<TicketEntity?> queryTicket({required String ticketId}) async {
    return (await repository.queryTicket(ticketId: ticketId))?.toEntity();
  }

  @override
  Future<List<TicketEntity>> queryTickets({required String userId}) async {
    return (await repository.queryTickets(userId: userId))
        .map((e) => e.toEntity())
        .toList();
  }

  @override
  Future<TicketEntity?> updateTicket(TicketEntity entity) async {
    return (await repository.updateTicket(TicketModel.fromEntity(entity)))
        ?.toEntity();
  }
}
