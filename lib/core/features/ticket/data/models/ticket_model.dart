// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cinema/core/features/ticket/domain/entities/ticket_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TicketModel {
  String? id;
  String? title;
  int? runtime;
  String? filmFormat;
  String? theater;
  DateTime? time;
  List<String>? seats;
  double? unitPrice;
  String? userId;
  DateTime? createAt;
  TicketModel({
    this.id,
    this.title,
    this.runtime,
    this.filmFormat,
    this.theater,
    this.time,
    this.seats,
    this.unitPrice,
    this.userId,
    this.createAt,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
        id: json['id'] as String?,
        title: json['title'] as String?,
        runtime: json["runtime"] as int?,
        filmFormat: json["filmFormat"] as String?,
        theater: json["theater"] as String?,
        time: DateTime.tryParse(json["time"]),
        seats: jsonDecode(json["seats"]) as List<String>?,
        unitPrice: json['unitPrice'] as double?,
        userId: json["userId"] as String?,
        createAt: DateTime.tryParse(json["createAt"]));
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'runtime': runtime,
      'filmFormat': filmFormat,
      'theater': theater,
      'time': time?.toUtc().toIso8601String(),
      'seats': jsonEncode(seats),
      'unitPrice': unitPrice,
      'userId': userId,
      'createAt': createAt?.toUtc().toIso8601String()
    };
  }

  factory TicketModel.fromEntity(TicketEntity entity) {
    return TicketModel(
        id: entity.id,
        title: entity.title,
        runtime: entity.runtime,
        filmFormat: entity.filmFormat,
        theater: entity.theater,
        time: entity.time,
        seats: entity.seats,
        unitPrice: entity.unitPrice,
        userId: entity.userId ?? FirebaseAuth.instance.currentUser?.uid,
        createAt: entity.createAt ?? DateTime.now());
  }

  TicketEntity toEntity() {
    return TicketEntity(
      id: id,
      title: title,
      runtime: runtime,
      filmFormat: filmFormat,
      theater: theater,
      time: time,
      seats: seats,
      unitPrice: unitPrice,
      userId: userId,
      createAt: createAt,
    );
  }
}
