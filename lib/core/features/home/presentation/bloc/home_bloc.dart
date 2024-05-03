import 'dart:async';

import 'package:cinema/core/common/model/bloc_status_state.dart';
import 'package:cinema/core/features/account/domain/usecases/account_usecases.implement.dart';
import 'package:cinema/core/features/home/domain/repository/home_repository.implement.dart';
import 'package:cinema/core/features/home/domain/usecases/home_usecases.dart';
import 'package:cinema/core/features/home/domain/usecases/home_usecases.implement.dart';
import 'package:cinema/core/features/home/presentation/bloc/home_event.dart';
import 'package:cinema/core/features/home/presentation/bloc/home_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState(state: BlocStatusState.init)) {
    on<GetUpcomingAndNowPlayingMovieEvent>(
        _onGetUpcomingAndNowPlayingMovieEvent);
    on<GetUpcomingNextPageEvent>(_onGetUpcomingNextPageEvent);
  }

  final HomeUseCases _homeUseCases =
      HomeUseCasesImplement(repository: HomeRepositoryImplement());
  // final LoginUsecase _loginUsecase = LoginUsecaseImplement();
  final AccountUsecasesImplement _accountUsecase = AccountUsecasesImplement();

  FutureOr<void> _onGetUpcomingAndNowPlayingMovieEvent(
      GetUpcomingAndNowPlayingMovieEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(state: BlocStatusState.loading));

    try {
      final nowPlayingMovies = _homeUseCases.getNowPlayingMovies(1);
      final upComingMovies = _homeUseCases.getUpcomingMovies();
      // final currentUser = await _loginUsecase.getCurrentUserInfo();
      final currentUser = await _accountUsecase.getAccountInfo();
      var response = await Future.wait([nowPlayingMovies, upComingMovies]);
      if ((response[0] != null) && (response[1] != null)) {
        emit(state.copyWith(
            state: BlocStatusState.success,
            nowPlayingMovies: response[0]!,
            upComingMovies: response[1]!,
            user: currentUser,
            page: 1));
      } else {
        emit(state.copyWith(
            message: 'Failed to download movies',
            state: BlocStatusState.failed));
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }

  FutureOr<void> _onGetUpcomingNextPageEvent(
      GetUpcomingNextPageEvent event, Emitter<HomeState> emit) async {
    state.page = state.page! + 1;
    try {
      final result = await _homeUseCases.getNowPlayingMovies(state.page!);
      final nowPlayingMovie = state.nowPlayingMovies;
      nowPlayingMovie!.addAll(result ?? []);
      (result != null)
          ? emit(state.copyWith(
              state: BlocStatusState.success,
              nowPlayingMovies: nowPlayingMovie))
          : emit(state.copyWith(
              state: BlocStatusState.success,
              message: "Failed to load more movies"));
    } catch (e) {}
  }
}
