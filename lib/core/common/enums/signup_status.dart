import 'package:cinema/core/utils/localizations.dart';
import 'package:flutter/widgets.dart';

enum SignUpStatus {
  success,
  weakPassword,
  emailAlreadyInUse,
  unknownError,
  unknownError2;

  String getTranslated(BuildContext context) {
    switch (this) {
      case SignUpStatus.success:
        return translates(context).success;
      case SignUpStatus.weakPassword:
        return translates(context).weakpassword;
      case SignUpStatus.emailAlreadyInUse:
        return translates(context).emailalreadyinuse;
      case SignUpStatus.unknownError2:
        return "Unknow error2";
      default:
        return translates(context).unknownerror;
    }
  }
}
