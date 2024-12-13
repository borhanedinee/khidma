import 'package:flutter/material.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:lottie/lottie.dart';

class LoadingItem extends StatelessWidget {
  const LoadingItem({
    super.key, required this.loadingLabel, required this.lottieAsset,
  });

  final String loadingLabel;
  final String lottieAsset;

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
            lottieAsset,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          loadingLabel,
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
