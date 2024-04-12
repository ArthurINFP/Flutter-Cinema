// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class MovieDetailEvent {
  String movieId;
  MovieDetailEvent({
    required this.movieId,
  });
}

class GetMovieDetailEvent extends MovieDetailEvent {
  String language;
  GetMovieDetailEvent({
    required this.language,
    required super.movieId,
  });
}

class GetMovieSessionEvent extends MovieDetailEvent {
  DateTime sessionDate;
  GetMovieSessionEvent({
    required this.sessionDate,
    required super.movieId,
  });
}
