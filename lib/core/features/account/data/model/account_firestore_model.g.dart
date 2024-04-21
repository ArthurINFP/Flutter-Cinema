// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_firestore_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountModel _$AccountModelFromJson(Map<String, dynamic> json) => AccountModel(
      avatarUrl: json['avatar_url'] as String?,
      fullName: json['full_name'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      phoneNumber: json['phone_number'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      city: json['city'] as String?,
    );

Map<String, dynamic> _$AccountModelToJson(AccountModel instance) =>
    <String, dynamic>{
      'avatar_url': instance.avatarUrl,
      'full_name': instance.fullName,
      'date_of_birth': instance.dateOfBirth,
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      'gender': instance.gender,
      'city': instance.city,
    };
