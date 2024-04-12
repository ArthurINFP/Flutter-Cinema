import 'package:json_annotation/json_annotation.dart';

part 'movie_cast.g.dart';

@JsonSerializable()
class MovieCast {
  final List<CastCrewMember>? cast;
  final List<CastCrewMember>? crew;
  String? directorName;
  MovieCast({this.cast, this.crew, this.directorName});

  factory MovieCast.fromJson(Map<String, dynamic> json) {
    var castMembers = <CastCrewMember>[];
    String? directorName;

    if (json['cast'] != null) {
      castMembers = (json['cast'] as List)
          .map((e) => CastCrewMember.fromJson(e))
          .toList();
    }

    var crewMembers = json['crew'] as List<dynamic>?;
    if (crewMembers != null) {
      for (var member in crewMembers) {
        if (member['job'] == 'Director') {
          directorName = member['name'];
          break; // Stop the loop once the director is found
        }
      }
    }

    return MovieCast(cast: castMembers, directorName: directorName);
  }

  // Return an instance of MovieCast with the found values

  Map<String, dynamic> toJson() => _$MovieCastToJson(this);

  String get castNames => cast?.map((e) => e.name ?? '').join(', ') ?? '';

  // Since we're now directly storing the director's name, no need for a method to extract it
}

@JsonSerializable()
class CastCrewMember {
  final String? name;

  CastCrewMember({this.name});

  factory CastCrewMember.fromJson(Map<String, dynamic> json) =>
      _$CastCrewMemberFromJson(json);
  Map<String, dynamic> toJson() => _$CastCrewMemberToJson(this);
}
