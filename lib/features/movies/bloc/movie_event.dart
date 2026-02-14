import 'package:movie_app/import_export.dart';

abstract class MovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchMovie extends MovieEvent {
  final String query;
  SearchMovie(this.query);

  @override
  List<Object?> get props => [query];
}

class ToggleFav extends MovieEvent {
  final String id;
  ToggleFav(this.id);

  @override
  List<Object?> get props => [id];
}
class FetchMovieDetail extends MovieEvent {
  final String id;
  FetchMovieDetail(this.id);

  @override
  List<Object?> get props => [id];
}

