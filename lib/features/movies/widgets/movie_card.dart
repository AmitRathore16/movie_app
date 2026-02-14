import 'package:movie_app/import_export.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailScreen(movie: movie),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.network(
                    movie.poster,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (_, __, ___) =>
                    const Icon(Icons.movie, size: 50),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: () {
                      context
                          .read<MovieBloc>()
                          .add(ToggleFav(movie.id));
                    },
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.black45,
                      child: Icon(
                        movie.isFav
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            movie.title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(
            movie.year,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
