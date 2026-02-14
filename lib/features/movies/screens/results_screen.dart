import 'package:movie_app/import_export.dart';


class ResultsScreen extends StatefulWidget {
  final String query;

  const ResultsScreen({super.key, required this.query});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.query);
    context.read<MovieBloc>().add(SearchMovie(widget.query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        backgroundColor: const Color(0xffF5F6FA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Search Results",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                context.read<MovieBloc>().add(SearchMovie(value));
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xff2979FF),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => controller.clear(),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieLoaded) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${state.movies.length} movies found",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<MovieBloc, MovieState>(
                builder: (context, state) {
                  if (state is MovieLoading) {
                    return const Center(
                        child: CircularProgressIndicator());
                  }
                  if (state is MovieLoaded) {
                    return GridView.builder(
                      itemCount: state.movies.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.62,
                      ),
                      itemBuilder: (_, index) {
                        return MovieCard(
                            movie: state.movies[index]);
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
