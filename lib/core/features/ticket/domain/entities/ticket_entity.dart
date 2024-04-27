// ignore_for_file: public_member_api_docs, sort_constructors_first
class TicketEntity {
  String? id;
  String? title;
  int? runtime;
  String? theater;
  String? filmFormat;
  String? photoURL;
  DateTime? time;
  List<String>? seats;
  double? unitPrice;
  String? userId;
  DateTime? createAt;

  TicketEntity({
    this.id,
    this.title,
    this.runtime,
    this.theater,
    this.filmFormat,
    this.photoURL,
    this.time,
    this.seats,
    this.unitPrice,
    this.userId,
    this.createAt,
  });
}
