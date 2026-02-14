class SearchMovieModel {
  final String imdbID;
  final String title;
  final String year;
  final String poster;

  SearchMovieModel({
    required this.imdbID,
    required this.title,
    required this.year,
    required this.poster,
  });

  factory SearchMovieModel.fromJson(Map<String, dynamic> json) {
    return SearchMovieModel(
      imdbID: json["imdbID"] ?? "",
      title: json["Title"] ?? "",
      year: json["Year"] ?? "",
      poster: json["Poster"] != "N/A"
          ? json["Poster"]
          : "",
    );
  }
}
