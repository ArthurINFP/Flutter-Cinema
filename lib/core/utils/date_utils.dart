extension DateUtilsExtension on DateTime {
  DateTime getDateOnly() {
    return copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      microsecond: 0,
      millisecond: 0,
    );
  }
}
