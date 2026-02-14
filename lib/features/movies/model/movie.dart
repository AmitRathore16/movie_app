class Movie {
  final String id;
  final String title;
  final String year;
  final String poster;
  final String plot;
  final List<String> genres;
  final double imdb;
  final int rotten;
  final int meta;
  final String runtime;
  final String rated;
  final String director;
  final List<String> actors;
  final bool isFav;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.poster,
    required this.plot,
    required this.genres,
    required this.imdb,
    required this.rotten,
    required this.meta,
    required this.runtime,
    required this.rated,
    required this.director,
    required this.actors,
    this.isFav = false,
  });

  Movie copyWith({bool? isFav}) {
    return Movie(
      id: id,
      title: title,
      year: year,
      poster: poster,
      plot: plot,
      genres: genres,
      imdb: imdb,
      rotten: rotten,
      meta: meta,
      runtime: runtime,
      rated: rated,
      director: director,
      actors: actors,
      isFav: isFav ?? this.isFav,
    );
  }
}
