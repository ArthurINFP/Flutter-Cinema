import 'package:cinema/core/features/home/data/models/movie_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'home_rest_api.g.dart';

@RestApi()
abstract class HomeRestApi {
  factory HomeRestApi(Dio dio, {String? baseUrl}) = _HomeRestApi;

  @GET('/movie/now_playing')
  Future<MovieResponse> getNowPlayingMovies(@Query("page") int page);

  @GET('/movie/upcoming')
  Future<MovieResponse> getUpcomingMovies();
}
