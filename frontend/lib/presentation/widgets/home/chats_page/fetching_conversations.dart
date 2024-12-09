import 'package:flutter/material.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:lottie/lottie.dart';

class FetchingChats extends StatelessWidget {
  const FetchingChats({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        SizedBox(
          height: 250,
          child: Lottie.asset(
            'assets/lottie/fetching_messages_loading.json',
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          'Loading Conversations ...',
          style: textTheme.headlineSmall!.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
