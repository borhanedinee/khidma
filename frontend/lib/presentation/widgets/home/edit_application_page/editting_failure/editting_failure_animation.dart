import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EdittingFailureAnimation extends StatelessWidget {
  const EdittingFailureAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Lottie.asset(
        'assets/lottie/lottie_failure_animation.json',
        repeat: false,
      ),
    );
  }
}
