import 'package:flutter/material.dart';
import 'package:khidma/main.dart';
import 'package:shimmer/shimmer.dart';

class PopularJobsShimmer extends StatelessWidget {
  const PopularJobsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (size.height - 40) * .3,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 6, // Number of shimmer placeholders
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              margin: const EdgeInsets.only(left: 15),
              width: size.width - 100,
              height: (size.height - 100) * .3,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        },
      ),
    );
  }
}
