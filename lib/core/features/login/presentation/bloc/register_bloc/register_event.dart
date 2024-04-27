// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:image_picker/image_picker.dart';

import 'package:cinema/core/features/account/domain/entity/account_entity.dart';

abstract class RegisterEvent {}

class RegisterWithEmailEvent extends RegisterEvent {
  AccountEntity entity;
  String password;
  XFile? image;
  RegisterWithEmailEvent({
    required this.entity,
    required this.password,
    this.image,
  });
}
