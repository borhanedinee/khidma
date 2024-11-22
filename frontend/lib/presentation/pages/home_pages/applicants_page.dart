// applicants page
import 'package:flutter/material.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:khidma/presentation/widgets/home/applicants_page/applicants_job_item.dart';
import 'package:khidma/presentation/widgets/home/my_app_bar.dart';

class ApplicantsPage extends StatelessWidget {
  const ApplicantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      child: Stack(
        children: [
          const MyAppBar(
            label: 'Applicants',
          ),
          Positioned.fill(
            top: 80,
            child: Container(
              height: size.height - 100,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(
                    20,
                  ),
                ),
              ),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  // in case , there are jobs added by user
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'View Applicants for Jobs you have added',
                      style: textTheme.bodySmall!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ...List.generate(
                    3,
                    (index) => const ApplicantsJobItem(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
