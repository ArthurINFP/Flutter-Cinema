import 'package:cinema/core/features/home/data/models/movie.dart';
import 'package:cinema/core/features/home/data/remote/home_rest_api.dart';
import 'package:cinema/core/features/home/data/remote/remote_datasource.dart';
import 'package:cinema/core/features/home/data/remote/remote_datasource.implement.dart';
import 'package:cinema/core/features/home/domain/repository/home_repository.dart';
import 'package:cinema/main.dart';

class HomeRepositoryImplement extends HomeRepository {
  HomeRemoteDatasource repository = HomeRemoteDatasourceImplement();
  final HomeRestApi api = HomeRestApi(dioClient.dio);
  @override
  Future<List<Movie>?> getNowPlayingMovies(int page) async {
    // via Dio
    // return repository.getUpcomingMovies();
    final response = await api.getNowPlayingMovies(page);
    return response.results;
  }

  @override
  Future<List<Movie>?> getUpcomingMovies() async {
    final response = await api.getUpcomingMovies();
    return response.results;
  }
}
