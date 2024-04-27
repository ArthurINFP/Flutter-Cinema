// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:image_picker/image_picker.dart';

import 'package:cinema/core/features/account/domain/entity/account_entity.dart';
import 'package:cinema/core/features/ticket/domain/entities/ticket_entity.dart';

abstract class AccountEvent {}

class GetAccountInfoEvent extends AccountEvent {}

class UpdateAccountInfoEvent extends AccountEvent {
  AccountEntity newEntity;
  UpdateAccountInfoEvent({
    required this.newEntity,
  });
}

class DeleteTicketAccountEvent extends AccountEvent {
  String ticketId;
  TicketEntity entity;
  DeleteTicketAccountEvent({
    required this.ticketId,
    required this.entity,
  });
}

class UpdateAccountAvatarEvent extends AccountEvent {
  XFile image;
  UpdateAccountAvatarEvent({
    required this.image,
  });
}
