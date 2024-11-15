import 'package:flutter/material.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class PopularJob extends StatelessWidget {
  final JobModel jobModel;
  final bool isLeftRadius;
  const PopularJob({
    super.key,
    required this.jobModel,
    required this.isLeftRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.only(left: 20),
        margin: const EdgeInsets.only(left: 5),
        width: size.width - 100,
        height: (size.height - 100) * .3,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
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
                  jobModel.companyName,
                  style: textTheme.titleMedium!.copyWith(
                    color: Colors.black87,
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
                  jobModel.jobTitle,
                  style: textTheme.titleSmall!.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  jobModel.jobType,
                  style: textTheme.bodySmall!.copyWith(
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
            // jobLocation

            // jobSalary and next Button
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  jobModel.jobSalary,
                  style: textTheme.bodyMedium!.copyWith(
                    color: Colors.black54,
                  ),
                ),
                const Spacer(),
                IconButton.filled(
                  focusColor: Colors.grey,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.navigate_next,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
