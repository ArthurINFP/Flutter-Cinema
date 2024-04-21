import 'package:cinema/core/features/home/data/models/movie.dart';

abstract class HomeRemoteDatasource {
  Future<List<Movie>?> getNowPlayingMovies();
}
