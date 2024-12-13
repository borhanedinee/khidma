import 'package:flutter/material.dart';

class SubmissionSuccessActionButtons extends StatelessWidget {
  final VoidCallback onViewApplications;
  final VoidCallback onBackToJobs;

  const SubmissionSuccessActionButtons({
    super.key,
    required this.onViewApplications,
    required this.onBackToJobs,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onViewApplications,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            'View Your Applications',
            style: TextStyle(fontSize: 16 , color: Colors.yellow),
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: onBackToJobs,
          child: const Text(
            'Back to Application',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}