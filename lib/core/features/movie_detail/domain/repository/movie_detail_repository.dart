import 'package:cinema/core/features/movie_detail/data/model/movie_cast.dart';
import 'package:cinema/core/features/movie_detail/data/model/movie_detail.dart';
import 'package:cinema/core/features/movie_detail/data/model/movie_release_info.dart';
import 'package:cinema/core/features/movie_detail/data/model/movie_session.dart';
import 'package:cinema/core/features/movie_detail/data/model/movie_trailers.dart';
import 'package:cinema/core/features/movie_detail/domain/entities/movie_session_entity.dart';

abstract class MovieDetailRepository {
  Future<MovieDetail> getMovieDetail(
      {required String movieId, required String language});

  Future<MovieCast> getMovieCast({
    required String movieId,
  });

  Future<MovieReleaseInfo> getMovieCertificate({
    required String movieId,
  });

  Future<MovieTrailers> getMovieTrailers({
    required String movieId,
  });

  Future<List<MovieSession>> getMovieSession(
      {required String movieId, required DateTime sessionDate});
}
