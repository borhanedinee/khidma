import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/constatnts/constants.dart';
import 'package:khidma/domain/models/application_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/home_pages/application_details_page.dart';
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
        () => ApplicationDetailsPage(
          applicationModel: applicationModel,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Card(
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    left: 20, top: 10, bottom: 10, right: 20),
                width: size.width,
                height: 130,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(.03),
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
                                () => ApplicationDetailsPage(
                                  applicationModel: applicationModel,
                                ),
                              ),
                              icon: const Icon(
                                Icons.navigate_next,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 40, top: 10, right: 30),
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
              Positioned(
                left: 0,
                right: 0,
                bottom: -80,
                child: Opacity(
                  opacity: .1,
                  child: Image.asset(
                    'assets/images/photo.png',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
