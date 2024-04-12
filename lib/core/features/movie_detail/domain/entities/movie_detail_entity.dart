class MovieDetailEntity {
  String title;
  String overview;
  String genre;
  String releaseDate;
  double voteAverage;
  int voteCount;
  int runtime;
  String castNames;
  String certificate;
  String youtubeName;
  String youtubeUrl;
  String posterUrl;
  String director;
  MovieDetailEntity({
    required this.director,
    required this.title,
    required this.overview,
    required this.genre,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.runtime,
    required this.castNames,
    required this.certificate,
    required this.youtubeName,
    required this.youtubeUrl,
    required this.posterUrl,
  });
}
