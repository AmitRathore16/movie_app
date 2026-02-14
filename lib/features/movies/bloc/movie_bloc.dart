import 'package:movie_app/import_export.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieApiService api = MovieApiService();

  List<Movie> currentResults = [];
  List<Movie> favourites = [];

  MovieBloc() : super(MovieLoaded([], [])) {

    on<SearchMovie>((event, emit) async {
      emit(MovieLoading());

      try {
        final searchResults =
        await api.searchMovies(event.query);

        if (searchResults.isEmpty) {
          emit(MovieLoaded([], favourites));
          return;
        }

        currentResults = searchResults.map((e) {
          return Movie(
            id: e.imdbID,
            title: e.title,
            year: e.year,
            poster: e.poster,
            plot: "",
            genres: [],
            imdb: 0,
            rotten: 0,
            meta: 0,
            runtime: "",
            rated: "",
            director: "",
            actors: [],
          );
        }).toList();

        emit(MovieLoaded(currentResults, favourites));
      } catch (e) {
        emit(MovieError("Failed to fetch movies. Please try again."));
      }
    });


    on<ToggleFav>((event, emit) {

      currentResults = currentResults.map((movie) {
        if (movie.id == event.id) {
          final updated =
          movie.copyWith(isFav: !movie.isFav);

          if (updated.isFav) {
            favourites.add(updated);
          } else {
            favourites.removeWhere(
                    (m) => m.id == updated.id);
          }

          return updated;
        }
        return movie;
      }).toList();

      emit(MovieLoaded(currentResults, favourites));
    });
    on<FetchMovieDetail>((event, emit) async {
      emit(MovieLoading());

      try {
        final detail = await api.getMovieDetail(event.id);

        int rotten = 0;

        for (var r in detail.ratings) {
          if (r["Source"] == "Rotten Tomatoes") {
            rotten = int.tryParse(
              r["Value"].replaceAll("%", ""),
            ) ??
                0;
          }
        }

        final updatedMovie = Movie(
          id: detail.imdbID,
          title: detail.title,
          year: detail.year,
          poster: detail.poster,
          plot: detail.plot,
          genres: detail.genre.split(",").map((e) => e.trim()).toList(),
          imdb: double.tryParse(detail.imdbRating) ?? 0,
          rotten: rotten,
          meta: int.tryParse(detail.metascore) ?? 0,
          runtime: detail.runtime,
          rated: detail.rated,
          director: detail.director,
          actors: detail.actors.split(",").map((e) => e.trim()).toList(),
          isFav: favourites.any((m) => m.id == detail.imdbID),
        );

        currentResults = currentResults.map((m) {
          if (m.id == event.id) {
            return updatedMovie;
          }
          return m;
        }).toList();

        emit(MovieLoaded(currentResults, favourites));
      } catch (e) {
        emit(MovieError("Failed to load movie details."));
      }

    });
  }
}
