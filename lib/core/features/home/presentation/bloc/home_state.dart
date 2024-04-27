// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cinema/core/features/account/domain/entity/account_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cinema/core/features/home/data/models/movie.dart';

abstract class HomeState {}

class InitialHomeState extends HomeState {}

class SuccessfulHomeState extends HomeState {
  List<Movie> upComingMovies;
  List<Movie> nowPlayingMovies;
  AccountEntity? user;

  SuccessfulHomeState({
    required this.upComingMovies,
    required this.nowPlayingMovies,
    required this.user,
  });
}

class FailedHomeState extends HomeState {
  String? message;
  FailedHomeState({
    this.message,
  });
}

class LoadingHomeState extends HomeState {}
