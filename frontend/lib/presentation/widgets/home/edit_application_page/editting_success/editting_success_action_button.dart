import 'package:flutter/material.dart';

class EdittingSuccessActionButtons extends StatelessWidget {
  final VoidCallback onViewApplications;
  final VoidCallback onBackToJobs;

  const EdittingSuccessActionButtons({
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
            'Preview Application',
            style: TextStyle(fontSize: 16 , color: Colors.white),
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