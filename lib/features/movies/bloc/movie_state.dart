import 'package:movie_app/import_export.dart';


abstract class MovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movies;
  final List<Movie> favs;

  MovieLoaded(this.movies, this.favs);

  @override
  List<Object?> get props => [movies, favs];
}
