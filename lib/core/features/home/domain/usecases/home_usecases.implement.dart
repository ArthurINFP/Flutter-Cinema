// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cinema/core/features/home/data/models/movie.dart';
import 'package:cinema/core/features/home/domain/repository/home_repository.dart';
import 'package:cinema/core/features/home/domain/repository/home_repository.implement.dart';
import 'package:cinema/core/features/home/domain/usecases/home_usecases.dart';

class HomeUseCasesImplement extends HomeUseCases {
  HomeRepository repository;
  HomeUseCasesImplement({
    required this.repository,
  });
  @override
  Future<List<Movie>?> getUpcomingMovies() {
    return repository.getUpcomingMovies();
  }
}
