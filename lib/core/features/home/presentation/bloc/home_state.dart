// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cinema/core/common/model/bloc_status_state.dart';
import 'package:cinema/core/features/account/domain/entity/account_entity.dart';
import 'package:cinema/core/features/home/data/models/movie.dart';

class HomeState {
  BlocStatusState state;
  List<Movie>? upComingMovies;
  List<Movie>? nowPlayingMovies;
  int? page;
  AccountEntity? user;
  String? message;

  HomeState(
      {required this.state,
      this.upComingMovies,
      this.nowPlayingMovies,
      this.page,
      this.user,
      this.message});

  HomeState copyWith(
      {required BlocStatusState state,
      List<Movie>? upComingMovies,
      List<Movie>? nowPlayingMovies,
      int? page,
      AccountEntity? user,
      String? message}) {
    return HomeState(
      state: state,
      upComingMovies: upComingMovies ?? this.upComingMovies,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      page: page ?? this.page,
      user: user ?? this.user,
      message: message,
    );
  }
}
 


// class InitialHomeState extends HomeState {}

// class SuccessfulHomeState extends HomeState {
//   List<Movie> upComingMovies;
//   List<Movie> nowPlayingMovies;
//   AccountEntity? user;

//   SuccessfulHomeState({
//     required this.upComingMovies,
//     required this.nowPlayingMovies,
//     required this.user,
//   });
// }

// class FailedHomeState extends HomeState {
//   String? message;
//   FailedHomeState({
//     this.message,
//   });
// }

// class LoadingHomeState extends HomeState {}
