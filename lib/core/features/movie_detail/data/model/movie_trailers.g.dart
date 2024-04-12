// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_trailers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieTrailers _$MovieTrailersFromJson(Map<String, dynamic> json) =>
    MovieTrailers(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Trailer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieTrailersToJson(MovieTrailers instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

Trailer _$TrailerFromJson(Map<String, dynamic> json) => Trailer(
      name: json['name'] as String?,
      key: json['key'] as String?,
      site: json['site'] as String?,
    );

Map<String, dynamic> _$TrailerToJson(Trailer instance) => <String, dynamic>{
      'name': instance.name,
      'key': instance.key,
      'site': instance.site,
    };
