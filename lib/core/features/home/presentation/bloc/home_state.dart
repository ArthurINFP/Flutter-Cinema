// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cinema/core/features/home/data/models/movie.dart';

abstract class HomeState {}

class InitialHomeState extends HomeState {}

class SuccessfulHomeState extends HomeState {
  List<Movie> movies;
  SuccessfulHomeState({
    required this.movies,
  });
}

class FailedHomeState extends HomeState {
  String? message;
  FailedHomeState({
    this.message,
  });
}

class LoadingHomeState extends HomeState {}
