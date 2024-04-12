// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cinema/core/features/movie_detail/data/model/movie_detail.dart';
import 'package:cinema/core/features/movie_detail/domain/entities/movie_detail_entity.dart';
import 'package:cinema/core/features/movie_detail/domain/entities/movie_session_entity.dart';

abstract class MovieDetailState {}

class InitMovieDetailState extends MovieDetailState {}

class LoadingMovieDetailState extends MovieDetailState {}

class SuccessMovieDetailState extends MovieDetailState {
  MovieDetailEntity movieDetailEntity;
  SuccessMovieDetailState({
    required this.movieDetailEntity,
  });
}

class SuccessMovieSessionSate extends MovieDetailState {
  List<MovieSessionEntity> entityList;
  SuccessMovieSessionSate({
    required this.entityList,
  });
}

class FailedMovieDetailState extends MovieDetailState {
  String message;
  FailedMovieDetailState({
    required this.message,
  });
}
