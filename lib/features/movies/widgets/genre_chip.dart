import 'package:movie_app/import_export.dart';

class GenreChip extends StatelessWidget {
  final String label;

  const GenreChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.blue.shade50,
      labelStyle: const TextStyle(color: Colors.blue),
    );
  }
}
