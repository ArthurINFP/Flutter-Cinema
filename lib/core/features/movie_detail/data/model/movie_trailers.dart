// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'movie_trailers.g.dart';

@JsonSerializable()
class MovieTrailers {
  final List<Trailer>? results;
  MovieTrailers({
    this.results,
  });

  factory MovieTrailers.fromJson(Map<String, dynamic> json) =>
      _$MovieTrailersFromJson(json);
  Map<String, dynamic> toJson() => _$MovieTrailersToJson(this);

  Trailer? getOfficialTrailer() {
    return results?.firstWhere(
      (trailer) {
        if (trailer.name?.toLowerCase().contains("trailer") ?? false) {
          return trailer.name?.toLowerCase().contains("trailer") ?? false;
        } else {
          return trailer.name?.toLowerCase().contains("teaser") ?? false;
        }
      },
    );
  }
}

@JsonSerializable()
class Trailer {
  final String? name;
  final String? key;
  final String? site;
  Trailer({
    this.name,
    this.key,
    this.site,
  });
  factory Trailer.fromJson(Map<String, dynamic> json) =>
      _$TrailerFromJson(json);
  Map<String, dynamic> toJson() => _$TrailerToJson(this);
}
