import 'package:cinema/core/features/movie_detail/data/model/movie_cast.dart';
import 'package:cinema/core/features/movie_detail/data/model/movie_detail.dart';
import 'package:cinema/core/features/movie_detail/data/model/movie_release_info.dart';
import 'package:cinema/core/features/movie_detail/data/model/movie_trailers.dart';
import 'package:cinema/core/features/movie_detail/domain/entities/movie_detail_entity.dart';
import 'package:cinema/core/features/movie_detail/domain/entities/movie_session_entity.dart';
import 'package:cinema/core/features/movie_detail/domain/repository/movie_detail_repository.dart';
import 'package:cinema/core/features/movie_detail/domain/repository/movie_detail_repository.implement.dart';
import 'package:cinema/core/features/movie_detail/domain/usecases/movie_detail_usecases.dart';

class MovieDetailUsecasesImplement extends MovieDetailUsecases {
  MovieDetailRepository repository = MovieDetailRepositoryImplement();
  @override
  Future<MovieCast?> getMovieCast({required String movieId}) {
    return repository.getMovieCast(movieId: movieId);
  }

  @override
  Future<MovieReleaseInfo?> getMovieCertificate({required String movieId}) {
    return repository.getMovieCertificate(movieId: movieId);
  }

  @override
  Future<MovieDetailEntity> getMovieDetail(
      {required String movieId, required String language}) async {
    final movieDetail =
        repository.getMovieDetail(movieId: movieId, language: 'en-US');
    final movieCast = repository.getMovieCast(movieId: movieId);
    final movieTrailers = repository.getMovieTrailers(movieId: movieId);
    final movieCertificate = repository.getMovieCertificate(movieId: movieId);

    List<dynamic> result = await Future.wait(
        [movieDetail, movieCast, movieTrailers, movieCertificate]);
    MovieDetail? detail = result[0];
    MovieCast? cast = result[1];
    MovieTrailers? trailers = result[2];
    MovieReleaseInfo? releaseInfo = result[3];

    MovieDetailEntity entity = MovieDetailEntity(
      title: detail?.title ?? "Updating",
      overview: detail?.overview ?? "Updating",
      genre: detail?.genresNames ?? "Updating",
      releaseDate: detail?.releaseDate ?? "Updating",
      voteAverage: detail?.rating ?? 0.0,
      voteCount: 0,
      runtime: detail?.runtime ?? 0,
      castNames: cast?.castNames ?? "Updating",
      certificate: releaseInfo?.getUsCertification() ?? "Updating",
      youtubeName: trailers?.getOfficialTrailer()?.name ?? "",
      youtubeUrl: trailers?.getOfficialTrailer()?.key ?? "VP4unOtFwSU",
      posterUrl: "https://image.tmdb.org/t/p/original" +
              "${detail?.posterPath}" ??
          "https://ih1.redbubble.net/image.1893341687.8294/fposter,small,wall_texture,product,750x1000.jpg",
      director: cast?.directorName ?? "Updating",
    );
    return entity;
  }

  @override
  Future<List<MovieSessionEntity>> getMovieSession(
      {required String movieId, required DateTime sessionDate}) async {
    final result = await repository.getMovieSession(
        movieId: movieId, sessionDate: sessionDate);
    return Future(() => result.map((e) => e.convertToEntity()).toList());
  }
}
