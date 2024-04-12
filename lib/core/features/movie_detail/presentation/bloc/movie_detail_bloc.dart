import 'dart:async';

import 'package:cinema/core/features/home/data/models/movie.dart';
import 'package:cinema/core/features/movie_detail/data/model/movie_cast.dart';
import 'package:cinema/core/features/movie_detail/data/model/movie_detail.dart';
import 'package:cinema/core/features/movie_detail/data/model/movie_release_info.dart';
import 'package:cinema/core/features/movie_detail/data/model/movie_trailers.dart';
import 'package:cinema/core/features/movie_detail/domain/entities/movie_detail_entity.dart';
import 'package:cinema/core/features/movie_detail/domain/usecases/movie_detail_usecases.dart';
import 'package:cinema/core/features/movie_detail/domain/usecases/movie_detail_usecases.implement.dart';
import 'package:cinema/core/features/movie_detail/presentation/bloc/movie_detail_event.dart';
import 'package:cinema/core/features/movie_detail/presentation/bloc/movie_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc() : super(InitMovieDetailState()) {
    on<GetMovieDetailEvent>(_onGetMovieDetailEvent);
    on<GetMovieSessionEvent>(_onGetMovieSessionEvent);
  }

  final MovieDetailUsecases usecases = MovieDetailUsecasesImplement();
  FutureOr<void> _onGetMovieDetailEvent(
      GetMovieDetailEvent event, Emitter<MovieDetailState> emit) async {
    emit(LoadingMovieDetailState());
    String movieId = event.movieId;
    print("Bloc is running ${event.movieId}");
    try {
      final entity = await usecases.getMovieDetail(
          movieId: movieId, language: event.language);
      emit(SuccessMovieDetailState(movieDetailEntity: entity));
    } catch (e) {
      print(e.toString());
      emit(FailedMovieDetailState(
          message: "Something went wrong at background"));
    }
  }

  FutureOr<void> _onGetMovieSessionEvent(
      GetMovieSessionEvent event, Emitter<MovieDetailState> emit) async {
    emit(LoadingMovieDetailState());
    try {
      final sessionList = await usecases.getMovieSession(
          movieId: event.movieId, sessionDate: event.sessionDate);
      emit(SuccessMovieSessionSate(entityList: sessionList));
    } catch (e) {
      emit(
          FailedMovieDetailState(message: "Something wrong at the background"));
    }
  }
}
