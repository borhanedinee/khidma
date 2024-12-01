import 'package:flutter/material.dart';

class EdittingFailureActionButtons extends StatelessWidget {
  final VoidCallback onTryAgain;
  final VoidCallback onBackToJobs;

  const EdittingFailureActionButtons({
    super.key,
    required this.onTryAgain,
    required this.onBackToJobs,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onTryAgain,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            'Try Again',
            style: TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: onBackToJobs,
          child: const Text(
            'Back to Edit Application',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}