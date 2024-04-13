// ignore_for_file: public_member_api_docs, sort_constructors_first
class TicketEntity {
  String? title;
  int? runtime;
  String? theater;
  String? filmFormat;
  DateTime? time;
  List<String>? seats;
  double? unitPrice;
  TicketEntity({
    this.title,
    this.runtime,
    this.theater,
    this.filmFormat,
    this.time,
    this.seats,
    this.unitPrice,
  });
}
