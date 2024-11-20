
import 'package:flutter/material.dart';
import 'package:khidma/main.dart';
import 'package:shimmer/shimmer.dart';

class JobDetailsPageShimmers extends StatelessWidget {
  const JobDetailsPageShimmers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First shimmer box with height 120
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade200,
              highlightColor: Colors.grey.shade100,
              child: Opacity(
                opacity: .5,
                child: Container(
                  width: size
                      .width, // Full width of the screen
                  height: 120, // Height 120
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
    
          // Space between boxes
          const SizedBox(height: 20),
    
          // Second shimmer box with height 300
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade200,
              highlightColor: Colors.grey.shade100,
              child: Opacity(
                opacity: .5,
                child: Container(
                  width: size
                      .width, // Full width of the screen
                  height: 300, // Height 300
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
  }
}