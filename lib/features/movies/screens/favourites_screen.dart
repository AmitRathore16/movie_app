import 'package:movie_app/import_export.dart';


class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {

              if (state is MovieLoaded) {

                if (state.favs.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite_border,
                            size: 60, color: Colors.grey),
                        SizedBox(height: 12),
                        Text(
                          "No favorites yet",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  );
                }

                return GridView.builder(
                  itemCount: state.favs.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.62,
                  ),
                  itemBuilder: (_, i) =>
                      MovieCard(movie: state.favs[i]),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
