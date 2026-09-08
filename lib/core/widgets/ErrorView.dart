import 'package:flutter/material.dart';
import '../../../../core/theming/theme_extension.dart';

class ErrorView extends StatelessWidget {
  final VoidCallback onRetry;

  const ErrorView({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 60,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              "Something went wrong",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: context.textColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Please try again later",
              style: TextStyle(
                color: context.subTextColor,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    context.isDark ? Colors.white : const Color(0xff6C63FF),
                foregroundColor: context.isDark ? Colors.black : Colors.white,
              ),
              child: const Text("Try Again"),
            ),
          ],
        ),
      ),
    );
  }
}
