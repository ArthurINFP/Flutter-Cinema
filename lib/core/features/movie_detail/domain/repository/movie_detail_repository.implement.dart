import 'dart:math';

import 'package:cinema/core/features/home/data/models/movie.dart';
import 'package:cinema/core/features/movie_detail/data/model/movie_cast.dart';
import 'package:cinema/core/features/movie_detail/data/model/movie_detail.dart';
import 'package:cinema/core/features/movie_detail/data/model/movie_release_info.dart';
import 'package:cinema/core/features/movie_detail/data/model/movie_session.dart';
import 'package:cinema/core/features/movie_detail/data/model/movie_trailers.dart';
import 'package:cinema/core/features/movie_detail/data/remote/movie_detail_rest_api.dart';
import 'package:cinema/core/features/movie_detail/domain/entities/movie_session_entity.dart';
import 'package:cinema/core/features/movie_detail/domain/repository/movie_detail_repository.dart';
import 'package:cinema/core/utils/date_utils.dart';
import 'package:cinema/main.dart';

class MovieDetailRepositoryImplement extends MovieDetailRepository {
  MovieDetailRestApi api = MovieDetailRestApi(dioClient.dio);
  @override
  Future<MovieCast> getMovieCast({required String movieId}) {
    return api.getMovieCast(movieId: movieId);
  }

  @override
  Future<MovieReleaseInfo> getMovieCertificate({required String movieId}) {
    return api.getMovieCertificate(movieId: movieId);
  }

  @override
  Future<MovieDetail> getMovieDetail(
      {required String movieId, required String language}) {
    return api.getMovieDetail(movieId: movieId, language: language);
  }

  @override
  Future<MovieTrailers> getMovieTrailers({required String movieId}) {
    return api.getMovieTrailers(movieId: movieId);
  }

  @override
  Future<List<MovieSession>> getMovieSession(
      {required String movieId, required DateTime sessionDate}) async {
    final dateOnly = sessionDate.getDateOnly();
    final theaterConstanst = [
      'Thiso Mall',
      'Gigamall',
      'Vạn Hành Mall',
      'Bitexco',
      'Hùng Vương',
      'AEON Mall Tân Phú',
      'AEON Mall Bình Tân'
    ];
    const refPrice = 1000;
    final filmFormatConstants = ['3D', '4D', '3D Max', 'Vietsub', 'Lồng tiếng'];

    final result = <MovieSession>[];
    for (var i = 0; i < 20; i++) {
      theaterConstanst.shuffle();
      filmFormatConstants.shuffle();
      result.add(MovieSession(
        sessionTime: dateOnly.copyWith(hour: Random().nextInt(23)),
        theaterName: theaterConstanst.first,
        filmFormat: filmFormatConstants.first,
        adultTicketPrice: refPrice,
        childTicketPrice: refPrice * 0.5,
        studentTicketPrice: refPrice * 0.7,
        vipTicketPrice: refPrice * 0.8,
      ));
    }
    return Future(() => result);
  }
}
