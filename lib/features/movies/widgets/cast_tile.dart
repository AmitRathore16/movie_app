import 'package:movie_app/import_export.dart';

class CastTile extends StatelessWidget {
  final String name;
  final String role;
  final bool isDirector;

  const CastTile({
    super.key,
    required this.name,
    required this.role,
    this.isDirector = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: isDirector
                ? const Color(0xffE3F2FD)
                : const Color(0xffEAD7B7),
            child: isDirector
                ? const Icon(
              Icons.videocam,
              color: Color(0xff2979FF),
            )
                : null,
          ),

          const SizedBox(width: 14),

          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                role,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
