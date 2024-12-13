import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/onboarding_controller.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class JobItem extends StatelessWidget {
  final OnBoardingController _pageController = Get.find();
  final JobModel jobModel;
  final bool isLeftRadius;
  JobItem({
    super.key,
    required this.jobModel,
    required this.isLeftRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isLeftRadius ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(left: 20),
        width: size.width - 80,
        height: (size.height) * .25,
        decoration: BoxDecoration(
          color: Colors.grey.shade200.withOpacity(.2),
          borderRadius: BorderRadius.horizontal(
            right: isLeftRadius ? Radius.circular(0) : Radius.circular(40),
            left: isLeftRadius ? Radius.circular(40) : Radius.circular(0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // logo and companyName
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(jobModel.companyLogo, height: 40),
                const SizedBox(width: 10),
                Text(
                  jobModel.company,
                  style: textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // jobTitle with jobType
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  jobModel.title,
                  style: textTheme.titleSmall!.copyWith(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  jobModel.type,
                  style: textTheme.bodySmall!.copyWith(color: Colors.white54),
                ),
              ],
            ),
            // jobLocation

            // jobSalary and next Button
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('${jobModel.salary.toInt()} DA',
                    style:
                        textTheme.titleSmall!.copyWith(color: Colors.white60)),
                const Spacer(),
                IconButton.filled(
                  onPressed: () {
                    _pageController.pageController.animateToPage(
                      3,
                      duration: Durations.extralong4,
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: const Icon(
                    Icons.navigate_next,
                    color: Colors.yellow,
                  ),
                ),
                const SizedBox(width: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
