// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cinema/core/common/enums/city.dart';
import 'package:cinema/core/features/account/domain/entity/account_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:cinema/core/common/enums/gender.dart';

part 'account_firestore_model.g.dart';

@JsonSerializable()
class AccountModel {
  @JsonKey(name: "avatar_url")
  String? avatarUrl;

  @JsonKey(name: "full_name")
  String? fullName;

  @JsonKey(name: "date_of_birth")
  String? dateOfBirth;

  @JsonKey(name: "phone_number")
  String? phoneNumber;

  String? email;
  String? gender;
  String? city;
  AccountModel({
    this.avatarUrl,
    this.fullName,
    this.dateOfBirth,
    this.phoneNumber,
    this.email,
    this.gender,
    this.city,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountModelToJson(this);

  factory AccountModel.fromEntity(AccountEntity accountEntity) => AccountModel(
        fullName: accountEntity.displayName,
        email: accountEntity.email,
        phoneNumber: accountEntity.phoneNumber,
        avatarUrl: accountEntity.photoURL,
        dateOfBirth: (accountEntity.dateOfBirth != null)
            ? DateFormat("dd/MM/yyyy").format(accountEntity.dateOfBirth!)
            : "",
        gender: accountEntity.gender?.getTitle() ?? "Other",
        city: accountEntity.city?.getString() ?? "",
      );
  AccountEntity toEntity({required String uid}) {
    return AccountEntity(
      uid: uid,
      displayName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      photoURL: avatarUrl,
      dateOfBirth: (dateOfBirth != null)
          ? DateFormat("dd/MM/yyyy").parse(dateOfBirth!)
          : null,
      gender: Gender.getGender(gender),
      city: City.getCity(city),
    );
  }
}
