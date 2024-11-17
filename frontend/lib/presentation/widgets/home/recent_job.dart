import 'package:flutter/material.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class RecentJob extends StatelessWidget {
  const RecentJob({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        margin: const EdgeInsets.only(bottom: 10),
        width: size.width,
        height: 130,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width - 40,
              child: Row(
                children: [
                  SizedBox(
                    width: (size.width - 40) * .12,
                    child: Image.asset(
                      'assets/logos/recruitingLOGO.png',
                      height: 40,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: (size.width - 40) * .55,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Horizon',
                          style: textTheme.titleSmall!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Software Engineer - Full-Stack',
                          overflow: TextOverflow.fade,
                          style: textTheme.bodySmall!.copyWith(
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: (size.width - 40) * .05,
                  ),
                  SizedBox(

                    child: IconButton.filled(
                      onPressed: () {},
                      icon: const Icon(Icons.navigate_next),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                '\$25k / Monthly',
                style: textTheme.bodyMedium!.copyWith(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
