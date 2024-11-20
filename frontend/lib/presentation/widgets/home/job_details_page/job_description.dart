
import 'package:flutter/material.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class JobDescription extends StatelessWidget {
  const JobDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            // TODO: modify job descriptions in DB to be longer
            'Join our dynamic team as a backend developer, where you\'ll design scalable server-side solutions, optimize databases, and collaborate with frontend teams to deliver seamless user experiences. You\'ll maintain APIs, troubleshoot performance issues, and implement cutting-edge technologies to support business growth.',
            style: textTheme.bodySmall!.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
