import 'package:movie_app/import_export.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MovieBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xffF5F6FA),
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        home: const SearchScreen(),
      ),
    );
  }
}
