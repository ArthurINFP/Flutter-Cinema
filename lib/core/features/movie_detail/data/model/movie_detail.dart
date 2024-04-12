// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:cinema/core/features/movie_detail/data/model/movie_trailers.dart';

part 'movie_detail.g.dart';

@JsonSerializable()
class MovieDetail {
  final int? id;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  final String? title;
  final List<MovieDetailGenres>? genres;
  final String? overview;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'release_date')
  final String? releaseDate;

  @JsonKey(name: 'vote_average')
  final double? rating;
  final int? runtime;
  MovieTrailers? movieTrailers;
  MovieDetail({
    this.id,
    this.backdropPath,
    this.title,
    this.genres,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.rating,
    this.runtime,
    this.movieTrailers,
  });

  String get genresNames =>
      genres
          ?.map((genre) => genre.name ?? '')
          .where((name) => name.isNotEmpty)
          .join(', ') ??
      '';

  factory MovieDetail.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDetailToJson(this);
}

@JsonSerializable()
class MovieDetailGenres {
  final int? id;
  final String? name;
  MovieDetailGenres({
    this.id,
    this.name,
  });

  factory MovieDetailGenres.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailGenresFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDetailGenresToJson(this);
}
