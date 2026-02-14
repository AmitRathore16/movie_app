class MovieDetailModel {
  final String imdbID;
  final String title;
  final String year;
  final String rated;
  final String runtime;
  final String genre;
  final String plot;
  final String director;
  final String actors;
  final String imdbRating;
  final List<dynamic> ratings;
  final String poster;
  final String metascore;

  MovieDetailModel({
    required this.imdbID,
    required this.title,
    required this.year,
    required this.rated,
    required this.runtime,
    required this.genre,
    required this.plot,
    required this.director,
    required this.actors,
    required this.imdbRating,
    required this.ratings,
    required this.poster,
    required this.metascore,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      imdbID: json["imdbID"] ?? "",
      title: json["Title"] ?? "",
      year: json["Year"] ?? "",
      rated: json["Rated"] ?? "",
      runtime: json["Runtime"] ?? "",
      genre: json["Genre"] ?? "",
      plot: json["Plot"] ?? "",
      director: json["Director"] ?? "",
      actors: json["Actors"] ?? "",
      imdbRating: json["imdbRating"] ?? "0",
      ratings: json["Ratings"] ?? [],
      poster: json["Poster"] ?? "",
      metascore: json["Metascore"] ?? "0",
    );
  }
}
