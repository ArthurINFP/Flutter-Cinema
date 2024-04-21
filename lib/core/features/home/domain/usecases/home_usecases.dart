import 'package:cinema/core/features/home/data/models/movie.dart';
import 'package:cinema/core/features/home/domain/repository/home_repository.dart';
import 'package:cinema/core/features/home/domain/repository/home_repository.implement.dart';

abstract class HomeUseCases {
  Future<List<Movie>?> getNowPlayingMovies();
  Future<List<Movie>?> getUpcomingMovies();
}
