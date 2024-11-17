
import 'package:flutter/material.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class ApplicantsJobItem extends StatelessWidget {
  const ApplicantsJobItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        padding: const EdgeInsets.only(left: 20 , top: 10 , bottom: 10),
        margin: const EdgeInsets.only(bottom: 10 , left: 12,right: 12),
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width,
              child: Row(
                children: [
                  Image.asset(
                    'assets/logos/recruitingLOGO.png',
                    height: 40,
                  ),
                  Spacer(),
                  SizedBox(
                    width: size.width * .6,
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
                  IconButton.filled(
                    onPressed: () {},
                    icon: const Icon(Icons.navigate_next),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40 , top: 10),
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
