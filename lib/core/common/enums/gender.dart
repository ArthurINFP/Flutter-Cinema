import 'package:cinema/core/utils/localizations.dart';
import 'package:flutter/material.dart';

enum Gender {
  male,
  female,
  other;

  String getTranslateTitle(BuildContext context) {
    switch (this) {
      case Gender.male:
        return translates(context).male;
      case Gender.female:
        return translates(context).female;
      case Gender.other:
        return translates(context).other;
    }
  }

  // For backend data
  static Gender getGender(String? gender) {
    switch (gender?.toLowerCase()) {
      case "male":
        return Gender.male;
      case "female":
        return Gender.male;
      default:
        return Gender.other;
    }
  }

  // For backend data
  String getTitle() {
    switch (this) {
      case Gender.male:
        return "Male";
      case Gender.female:
        return "Female";
      case Gender.other:
        return "Other";
    }
  }
}
