import 'package:flutter/material.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:lottie/lottie.dart';

class EmptyJobApplications extends StatelessWidget {
  const EmptyJobApplications({
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
        Text(
          'No Applicants Yet',
          style: textTheme.headlineSmall!.copyWith(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'This job is still waiting for its first applicant\n stay tuned!',
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    ));
  }
}
