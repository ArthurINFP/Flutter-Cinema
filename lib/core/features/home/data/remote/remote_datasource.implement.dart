// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cinema/core/features/home/data/models/movie_response.dart';
import 'package:cinema/main.dart';

import 'package:cinema/core/features/home/data/models/movie.dart';
import 'package:cinema/core/features/home/data/remote/remote_datasource.dart';

class HomeRemoteDatasourceImplement extends HomeRemoteDatasource {
  @override
  Future<List<Movie>?> getNowPlayingMovies() async {
    final result = await dioClient.dio.get('/movie/now_playing');
    final responseJson = result.data as Map<String, dynamic>;
    final response = MovieResponse.fromJson(responseJson);
    return response.results;
  }
}
