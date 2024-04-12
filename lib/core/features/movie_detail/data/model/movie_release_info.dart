import 'package:json_annotation/json_annotation.dart';

part 'movie_release_info.g.dart';

@JsonSerializable()
class MovieReleaseInfo {
  final int? id;
  final List<ReleaseInfo>? results; // Make results nullable

  MovieReleaseInfo({this.id, this.results}); // Adjust constructor

  factory MovieReleaseInfo.fromJson(Map<String, dynamic> json) =>
      _$MovieReleaseInfoFromJson(json);
  Map<String, dynamic> toJson() => _$MovieReleaseInfoToJson(this);

  String? getUsCertification() {
    // Check if results is not null before using it
    if (results == null) return null;

    final usReleaseInfo = results?.firstWhere((info) => info.iso_3166_1 == 'US',
        orElse: () => ReleaseInfo(iso_3166_1: 'US', release_dates: []));
    return usReleaseInfo?.release_dates?.isNotEmpty ?? false
        ? usReleaseInfo?.release_dates?.first.certification
        : null;
  }
}

@JsonSerializable()
class ReleaseInfo {
  final String? iso_3166_1;
  final List<ReleaseDate>? release_dates; // This was already nullable

  ReleaseInfo(
      {this.iso_3166_1,
      this.release_dates}); // Adjust constructor for nullable release_dates

  factory ReleaseInfo.fromJson(Map<String, dynamic> json) =>
      _$ReleaseInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ReleaseInfoToJson(this);
}

@JsonSerializable()
class ReleaseDate {
  final String? certification;

  ReleaseDate({required this.certification});

  factory ReleaseDate.fromJson(Map<String, dynamic> json) =>
      _$ReleaseDateFromJson(json);
  Map<String, dynamic> toJson() => _$ReleaseDateToJson(this);
}
