import 'package:cinema/core/features/home/data/models/movie.dart';

abstract class HomeRepository {
  Future<List<Movie>?> getNowPlayingMovies(int page);
  Future<List<Movie>?> getUpcomingMovies();
}
