import 'package:cinema/core/features/movie_detail/data/model/movie_cast.dart';
import 'package:cinema/core/features/movie_detail/data/model/movie_detail.dart';
import 'package:cinema/core/features/movie_detail/data/model/movie_release_info.dart';
import 'package:cinema/core/features/movie_detail/data/model/movie_trailers.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'movie_detail_rest_api.g.dart';

@RestApi()
abstract class MovieDetailRestApi {
  factory MovieDetailRestApi(Dio dio, {String? baseUrl}) = _MovieDetailRestApi;

  @GET('/movie/{movie_id}')
  Future<MovieDetail> getMovieDetail(
      {@Path("movie_id") required String movieId,
      @Query("language") required String language});

  @GET('/movie/{movie_id}/credits')
  Future<MovieCast> getMovieCast({
    @Path("movie_id") required String movieId,
  });

  @GET('/movie/{movie_id}/release_dates')
  Future<MovieReleaseInfo> getMovieCertificate({
    @Path("movie_id") required String movieId,
  });

  @GET('/movie/{movie_id}/videos')
  Future<MovieTrailers> getMovieTrailers({
    @Path("movie_id") required String movieId,
  });
}
