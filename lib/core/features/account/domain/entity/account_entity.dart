import 'package:cinema/core/common/enums/city.dart';
import 'package:cinema/core/common/enums/gender.dart';

class AccountEntity {
  final String uid;
  String? displayName;
  String? email;
  String? phoneNumber;
  String? photoURL;
  DateTime? dateOfBirth;
  Gender? gender;
  City? city;
  AccountEntity({
    required this.uid,
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoURL,
    this.dateOfBirth,
    this.gender,
    this.city,
  });

  // The copyWith method
  AccountEntity copyWith({
    String? uid,
    String? displayName,
    String? email,
    String? phoneNumber,
    String? photoURL,
    DateTime? dateOfBirth,
    Gender? gender,
    City? city,
  }) {
    return AccountEntity(
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoURL: photoURL ?? this.photoURL,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      city: city ?? this.city,
    );
  }

  @override
  bool operator ==(covariant AccountEntity other) {
    if (identical(this, other)) {
      return true;
    }

    return other.uid == uid &&
        other.displayName == displayName &&
        other.photoURL == photoURL &&
        other.phoneNumber == phoneNumber &&
        other.email == email &&
        other.gender == gender &&
        other.city == city &&
        other.dateOfBirth == dateOfBirth;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        displayName.hashCode ^
        photoURL.hashCode ^
        phoneNumber.hashCode ^
        email.hashCode ^
        gender.hashCode ^
        city.hashCode ^
        dateOfBirth.hashCode;
  }
}
