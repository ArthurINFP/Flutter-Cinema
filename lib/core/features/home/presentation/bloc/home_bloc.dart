import 'dart:async';

import 'package:cinema/core/features/home/domain/repository/home_repository.implement.dart';
import 'package:cinema/core/features/home/domain/usecases/home_usecases.dart';
import 'package:cinema/core/features/home/domain/usecases/home_usecases.implement.dart';
import 'package:cinema/core/features/home/presentation/bloc/home_event.dart';
import 'package:cinema/core/features/home/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialHomeState()) {
    on<GetUpcomingMovieEvent>(_onGetUpcomingMovieEvent);
  }

  final HomeUseCases useCases =
      HomeUseCasesImplement(repository: HomeRepositoryImplement());

  FutureOr<void> _onGetUpcomingMovieEvent(
      GetUpcomingMovieEvent event, Emitter<HomeState> emitter) async {
    emit(LoadingHomeState());
    try {
      final movies = await useCases.getUpcomingMovies();
      if (movies != null) {
        emit(SuccessfulHomeState(movies: movies));
      } else {
        emit(FailedHomeState(message: 'Failed to download movies'));
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }
}
