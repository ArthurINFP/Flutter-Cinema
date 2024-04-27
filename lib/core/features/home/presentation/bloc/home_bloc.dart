import 'dart:async';

import 'package:cinema/core/features/account/domain/usecases/account_usecases.implement.dart';
import 'package:cinema/core/features/home/data/models/movie.dart';
import 'package:cinema/core/features/home/domain/repository/home_repository.implement.dart';
import 'package:cinema/core/features/home/domain/usecases/home_usecases.dart';
import 'package:cinema/core/features/home/domain/usecases/home_usecases.implement.dart';
import 'package:cinema/core/features/home/presentation/bloc/home_event.dart';
import 'package:cinema/core/features/home/presentation/bloc/home_state.dart';
import 'package:cinema/core/features/login/domain/usecases/login_usecase.dart';
import 'package:cinema/core/features/login/domain/usecases/login_usecases.implement.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialHomeState()) {
    on<GetUpcomingAndNowPlayingMovieEvent>(
        _onGetUpcomingAndNowPlayingMovieEvent);
  }

  final HomeUseCases _homeUseCases =
      HomeUseCasesImplement(repository: HomeRepositoryImplement());
  // final LoginUsecase _loginUsecase = LoginUsecaseImplement();
  final AccountUsecasesImplement _accountUsecase = AccountUsecasesImplement();

  FutureOr<void> _onGetUpcomingAndNowPlayingMovieEvent(
      GetUpcomingAndNowPlayingMovieEvent event, Emitter<HomeState> emit) async {
    emit(LoadingHomeState());
    await Future.delayed(const Duration(seconds: 2));

    try {
      final nowPlayingMovies = _homeUseCases.getNowPlayingMovies();
      final upComingMovies = _homeUseCases.getUpcomingMovies();
      // final currentUser = await _loginUsecase.getCurrentUserInfo();
      final currentUser = await _accountUsecase.getAccountInfo();
      var response = await Future.wait([nowPlayingMovies, upComingMovies]);
      if ((response[0] != null) && (response[1] != null)) {
        emit(SuccessfulHomeState(
            nowPlayingMovies: response[0]!,
            upComingMovies: response[1]!,
            user: currentUser));
      } else {
        emit(FailedHomeState(message: 'Failed to download movies'));
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }
}
