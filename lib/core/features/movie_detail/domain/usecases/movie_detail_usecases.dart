import 'package:cinema/core/features/movie_detail/data/model/movie_cast.dart';
import 'package:cinema/core/features/movie_detail/data/model/movie_detail.dart';
import 'package:cinema/core/features/movie_detail/data/model/movie_release_info.dart';
import 'package:cinema/core/features/movie_detail/data/model/movie_trailers.dart';
import 'package:cinema/core/features/movie_detail/domain/entities/movie_detail_entity.dart';
import 'package:cinema/core/features/movie_detail/domain/entities/movie_session_entity.dart';

abstract class MovieDetailUsecases {
  Future<MovieDetailEntity> getMovieDetail(
      {required String movieId, required String language});

  Future<List<MovieSessionEntity>> getMovieSession(
      {required String movieId, required DateTime sessionDate});
}
