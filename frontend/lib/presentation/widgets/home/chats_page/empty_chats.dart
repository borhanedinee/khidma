import 'package:flutter/material.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:lottie/lottie.dart';

class EmptyChats extends StatelessWidget {
  const EmptyChats({
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
            'assets/lottie/lottie_empty_chat.json',
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          'Empty Chats!',
          style: textTheme.headlineMedium!.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            'You can start your chats with applicants that applied for your jobs, or recruiters you applied for their jobs will dm you here',
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium!.copyWith(
              color: Colors.black54,
            ),
          ),
        )
      ],
    );
  }
}
