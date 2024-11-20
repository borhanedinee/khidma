import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/constants.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/home_pages/job_details_page.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class RecentJob extends StatelessWidget {
  final JobModel jobModel;
  const RecentJob({
    super.key,
    required this.jobModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(JobDetailsPage(jobModel: jobModel));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
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
                          child: Image.network(
                            '$IMAGE_URL/${jobModel.companyLogo}',
                            scale: 1.0,
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
                                jobModel.company,
                                style: textTheme.titleMedium!.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                '${jobModel.title} - ${jobModel.type}',
                                overflow: TextOverflow.fade,
                                style: textTheme.bodySmall!.copyWith(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: (size.width - 40) * .2,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Text(
                      '\$${jobModel.salary.toInt()} / Monthly',
                      style: textTheme.bodyMedium!.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: -80,
              child: Opacity(
                opacity: .05,
                child: Image.asset(
                  'assets/images/photo.png',
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: 20,
              child: IconButton.filled(
                onPressed: () {
                  Get.to(JobDetailsPage(jobModel: jobModel));
                },
                icon: const Icon(Icons.navigate_next),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
