// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:cinema/core/features/ticket/domain/entities/ticket_entity.dart';

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
  String? photoURL;
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
    this.photoURL,
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
        seats: (jsonDecode(json["seats"]) as List<dynamic>)
            .map((e) => e as String)
            .toList(),
        unitPrice: json['unitPrice'] as double?,
        photoURL: json['photoUrl'] as String?,
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
      'photoUrl': photoURL,
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
        photoURL: entity.photoURL,
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
      photoURL: photoURL,
      userId: userId,
      createAt: createAt,
    );
  }

  TicketModel copyWith({
    String? id,
    String? title,
    int? runtime,
    String? filmFormat,
    String? theater,
    DateTime? time,
    List<String>? seats,
    double? unitPrice,
    String? userId,
    String? photoURL,
    DateTime? createAt,
  }) {
    return TicketModel(
      id: id ?? this.id,
      title: title ?? this.title,
      runtime: runtime ?? this.runtime,
      filmFormat: filmFormat ?? this.filmFormat,
      theater: theater ?? this.theater,
      time: time ?? this.time,
      seats: seats ?? this.seats,
      unitPrice: unitPrice ?? this.unitPrice,
      userId: userId ?? this.userId,
      photoURL: photoURL ?? this.photoURL,
      createAt: createAt ?? this.createAt,
    );
  }
}
