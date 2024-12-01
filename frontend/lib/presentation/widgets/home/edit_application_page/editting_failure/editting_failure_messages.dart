import 'package:flutter/material.dart';

class EdittingFailureMessage extends StatelessWidget {
  const EdittingFailureMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Editting Failed',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          'We encountered an error while editting your application. Please check your internet connection and try again.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
                height: 1.5,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}