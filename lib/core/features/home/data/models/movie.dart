// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cinema/core/common/enums/genre.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  int? id;
  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'genre_ids')
  List<int>? genreIds;

  @JsonKey(name: 'poster_path')
  String? posterPath;

  @JsonKey(name: 'vote_average')
  double? voteAverage;

  List<String?>? getGenre(String languageCode) {
    final genreString = genreIds
        ?.map(
          (e) => Genre.getGenreById(e)?.getGenreString(languageCode),
        )
        .toList();

    return genreString;
  }

  String get posterUrl =>
      "https://image.tmdb.org/t/p/original${posterPath ?? ""}";
  Movie({
    this.title,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
