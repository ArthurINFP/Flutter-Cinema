// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetail _$MovieDetailFromJson(Map<String, dynamic> json) => MovieDetail(
      id: json['id'] as int?,
      backdropPath: json['backdrop_path'] as String?,
      title: json['title'] as String?,
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => MovieDetailGenres.fromJson(e as Map<String, dynamic>))
          .toList(),
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] as String?,
      rating: (json['vote_average'] as num?)?.toDouble(),
      runtime: json['runtime'] as int?,
      movieTrailers: json['movieTrailers'] == null
          ? null
          : MovieTrailers.fromJson(
              json['movieTrailers'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieDetailToJson(MovieDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'backdrop_path': instance.backdropPath,
      'title': instance.title,
      'genres': instance.genres,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate,
      'vote_average': instance.rating,
      'runtime': instance.runtime,
      'movieTrailers': instance.movieTrailers,
    };

MovieDetailGenres _$MovieDetailGenresFromJson(Map<String, dynamic> json) =>
    MovieDetailGenres(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$MovieDetailGenresToJson(MovieDetailGenres instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
