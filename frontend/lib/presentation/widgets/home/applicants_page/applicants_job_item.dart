import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/constatnts/constants.dart';
import 'package:khidma/domain/models/application_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/home_pages/view_job_and_application_details_page.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class ApplicationItem extends StatelessWidget {
  const ApplicationItem({
    super.key,
    required this.applicationModel,
  });

  final ApplicationModel applicationModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
        () => ViewJobAndApplicationDetailsPage(
          applicationModel: applicationModel,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          padding:
              const EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 20),
          margin: const EdgeInsets.only(bottom: 10, left: 12, right: 12),
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
                    SizedBox(
                      width: (size.width - 40) * .1,
                      child: Image.network(
                        '$IMAGE_URL/${applicationModel.job.companyLogo}',
                        height: 40,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: (size.width - 40) * .6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            applicationModel.job.company,
                            style: textTheme.titleSmall!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${applicationModel.job.title} - ${applicationModel.job.type}',
                            overflow: TextOverflow.fade,
                            style: textTheme.bodySmall!.copyWith(
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: (size.width - 40) * .12,
                      child: IconButton.filled(
                        onPressed: () => Get.to(
                          () => ViewJobAndApplicationDetailsPage(
                            applicationModel: applicationModel,
                          ),
                        ),
                        icon: const Icon(Icons.navigate_next , size: 16,),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, top: 10, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${applicationModel.job.salary.toInt()} DA',
                      style: textTheme.bodyMedium!.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      applicationModel.timeAgo(),
                      style: textTheme.bodyMedium!.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
