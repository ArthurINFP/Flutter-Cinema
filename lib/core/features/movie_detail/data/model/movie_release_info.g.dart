// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_release_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieReleaseInfo _$MovieReleaseInfoFromJson(Map<String, dynamic> json) =>
    MovieReleaseInfo(
      id: json['id'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => ReleaseInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieReleaseInfoToJson(MovieReleaseInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'results': instance.results,
    };

ReleaseInfo _$ReleaseInfoFromJson(Map<String, dynamic> json) => ReleaseInfo(
      iso_3166_1: json['iso_3166_1'] as String?,
      release_dates: (json['release_dates'] as List<dynamic>?)
          ?.map((e) => ReleaseDate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReleaseInfoToJson(ReleaseInfo instance) =>
    <String, dynamic>{
      'iso_3166_1': instance.iso_3166_1,
      'release_dates': instance.release_dates,
    };

ReleaseDate _$ReleaseDateFromJson(Map<String, dynamic> json) => ReleaseDate(
      certification: json['certification'] as String?,
    );

Map<String, dynamic> _$ReleaseDateToJson(ReleaseDate instance) =>
    <String, dynamic>{
      'certification': instance.certification,
    };
