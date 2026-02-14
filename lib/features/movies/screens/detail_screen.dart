import 'package:movie_app/import_export.dart';

class DetailScreen extends StatefulWidget {
  final Movie movie;

  const DetailScreen({super.key, required this.movie});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  @override
  void initState() {
    super.initState();

    context.read<MovieBloc>().add(
      FetchMovieDetail(widget.movie.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {

        if (state is MovieLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        Movie currentMovie = widget.movie;

        if (state is MovieLoaded) {
          final match = state.movies
              .where((m) => m.id == widget.movie.id)
              .toList();

          if (match.isNotEmpty) {
            currentMovie = match.first;
          }
        }

        return Scaffold(
          backgroundColor: const Color(0xffF5F6FA),
          body: Stack(
            children: [

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.60,
                width: double.infinity,
                child: Image.network(
                  currentMovie.poster,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                  const Icon(Icons.movie, size: 80),
                ),
              ),

              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.40,
                left: 0,
                right: 0,
                child: Container(
                  height: 120,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Color(0xffF5F6FA),
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 50,
                left: 20,
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.black45,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),

              Positioned(
                top: 50,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    context.read<MovieBloc>().add(
                      ToggleFav(currentMovie.id),
                    );
                  },
                  child: CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.black45,
                    child: Icon(
                      currentMovie.isFav
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 20),
                  padding: const EdgeInsets.fromLTRB(
                      24, 28, 24, 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  height:
                  MediaQuery.of(context).size.height *
                      0.55,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Text(
                          currentMovie.title,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "${currentMovie.year} • ${currentMovie.rated} • ${currentMovie.runtime}",
                          style: const TextStyle(
                            color: Color(0xff2979FF),
                            fontWeight:
                            FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 18),

                        Wrap(
                          spacing: 10,
                          children: currentMovie.genres
                              .map((g) => Container(
                            padding:
                            const EdgeInsets
                                .symmetric(
                                horizontal:
                                16,
                                vertical:
                                6),
                            decoration:
                            BoxDecoration(
                              color: const Color(
                                  0xffE3F2FD),
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  20),
                            ),
                            child: Text(
                              g,
                              style:
                              const TextStyle(
                                color: Color(
                                    0xff2979FF),
                                fontWeight:
                                FontWeight
                                    .w500,
                              ),
                            ),
                          ))
                              .toList(),
                        ),

                        const SizedBox(height: 24),
                        const Divider(),
                        const SizedBox(height: 20),

                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const Text("IMDB"),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        color: Colors.amber,
                                        size: 18),
                                    const SizedBox(width: 4),
                                    Text(
                                        "${currentMovie.imdb}/10"),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  "ROTTEN\nTOMATOES",
                                  textAlign:
                                  TextAlign.center,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                    "${currentMovie.rotten}%"),
                              ],
                            ),
                            Column(
                              children: [
                                const Text("METACRITIC"),
                                const SizedBox(height: 6),
                                Text(
                                    "${currentMovie.meta}/100"),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),
                        const Divider(),
                        const SizedBox(height: 20),

                        const Text(
                          "PLOT",
                          style: TextStyle(
                            fontWeight:
                            FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          currentMovie.plot,
                          style: const TextStyle(
                            height: 1.6,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 24),

                        const Text(
                          "CAST & CREW",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                            letterSpacing: 1,
                          ),
                        ),

                        const SizedBox(height: 16),

                        CastTile(
                          name: currentMovie.director,
                          role: "Director",
                          isDirector: true,
                        ),

                        ...currentMovie.actors.map(
                              (actor) => CastTile(
                            name: actor,
                            role: "",
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
