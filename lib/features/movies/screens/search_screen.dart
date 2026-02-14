
import 'package:movie_app/import_export.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      body: currentIndex == 0
          ? SafeArea(
        child: Column(
          children: [
            const Spacer(),
            const Text(
              "Search",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ResultsScreen(query: value),
                      ),
                    );
                  }
                },
                decoration: InputDecoration(
                  hintText: "Search for your favorite movies",
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xff2979FF),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      )
          : const FavoritesScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: const Color(0xff2979FF),
        unselectedItemColor: Colors.grey,
        onTap: (i) => setState(() => currentIndex = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}
