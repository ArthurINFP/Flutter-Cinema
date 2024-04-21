import 'package:cinema/core/utils/localizations.dart';
import 'package:flutter/material.dart';

enum City {
  hochiminh,
  hanoi,
  danang;

  String getTranslateString(BuildContext context) {
    switch (this) {
      case City.hochiminh:
        return translates(context).hochiminhcity;
      case City.hanoi:
        return translates(context).hanoicity;
      case City.danang:
        return translates(context).danangcity;
    }
  }

  // For backend data
  static City getCity(String? cityString) {
    switch (cityString?.toLowerCase()) {
      case "ha noi":
        return City.hanoi;
      case "da nang":
        return City.danang;
      default:
        return City.hochiminh;
    }
  }

  String getString() {
    switch (this) {
      case City.hanoi:
        return "Ha Noi";
      case City.danang:
        return "Da Nang";
      default:
        return "Ho Chi Minh";
    }
  }
}
