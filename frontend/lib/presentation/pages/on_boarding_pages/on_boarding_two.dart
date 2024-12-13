import 'package:flutter/material.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class OnBoardingTwo extends StatelessWidget {
  const OnBoardingTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 7, 73, 135),
      body: Column(
        children: [
          SizedBox(
            height: size.height * .1
          ),
          Center(
            child: Image.asset(
              'assets/images/onbrd2.png',
              fit: BoxFit.fill,
              height: size.height * .5,
            ),
          ),
          SizedBox(
            height: size.height * .05,
          ),
          SizedBox(
            width: size.width - 30,
            child: Column(
              children: [
                Text(
                  'Connect with Opportunity',
                  style: textTheme.titleLarge!.copyWith(
                    color: Colors.yellow
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Discover jobs tailored to your skills and interests. Connect with top companies and take the next step in your career journey.',
                  style: textTheme.bodySmall,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
