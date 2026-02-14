import 'package:movie_app/import_export.dart';
import 'package:http/http.dart' as http;

class MovieApiService {
  static const String _baseUrl = ApiConstants.baseUrl;
  static const String _apiKey = ApiConstants.apiKey;

  Future<List<SearchMovieModel>> searchMovies(String query) async {
    final response = await http.get(
      Uri.parse("$_baseUrl?apikey=$_apiKey&s=$query"),
    );

    final data = jsonDecode(response.body);

    if (data["Response"] == "False") {
      return [];
    }



    return (data["Search"] as List)
        .map((e) => SearchMovieModel.fromJson(e))
        .toList();
  }

  Future<MovieDetailModel> getMovieDetail(String imdbID) async {
    final response = await http.get(
      Uri.parse("$_baseUrl?apikey=$_apiKey&i=$imdbID&plot=full"),
    );

    final data = jsonDecode(response.body);

    return MovieDetailModel.fromJson(data);
  }
}
