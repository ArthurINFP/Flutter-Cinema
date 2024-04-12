// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_cast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieCast _$MovieCastFromJson(Map<String, dynamic> json) => MovieCast(
      cast: (json['cast'] as List<dynamic>?)
          ?.map((e) => CastCrewMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      crew: (json['crew'] as List<dynamic>?)
          ?.map((e) => CastCrewMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      directorName: json['directorName'] as String?,
    );

Map<String, dynamic> _$MovieCastToJson(MovieCast instance) => <String, dynamic>{
      'cast': instance.cast,
      'crew': instance.crew,
      'directorName': instance.directorName,
    };

CastCrewMember _$CastCrewMemberFromJson(Map<String, dynamic> json) =>
    CastCrewMember(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CastCrewMemberToJson(CastCrewMember instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
