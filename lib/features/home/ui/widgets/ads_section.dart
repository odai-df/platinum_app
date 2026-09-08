import 'package:flutter/material.dart';

class AdCard extends StatelessWidget {
  final String title;
  final String image;

  const AdCard({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 180,

      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.35)
                : Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],

        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
      ),

      child: Container(
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),

          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.75),
              Colors.black.withOpacity(0.15),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),

            const SizedBox(height: 6),

            // Text(
            //   subtitle,
            //   style: const TextStyle(
            //     color: Colors.white70,
            //     fontSize: 14,
            //   ),
            //   overflow: TextOverflow.ellipsis,
            //   maxLines: 2,
            // ),
          ],
        ),
      ),
    );
  }
}