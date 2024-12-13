
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyJobsForRecruiter extends StatelessWidget {
  const EmptyJobsForRecruiter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        Lottie.asset(
          'assets/lottie/lottie_empty_bookmarks.json',
        ),
        const SizedBox(
          height: 40,
        ),
        const Text(
          'You Have no posted jobs.',
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            'Post Your First Job',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ],
    ));
  }
}
