import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class JobDetailsAppBar extends StatelessWidget {
  const JobDetailsAppBar({
    super.key,
    required this.jobModel,
  });

  final JobModel jobModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.navigate_before,
            ),
          ),
          Text(
            jobModel.company,
            style: textTheme.titleMedium!.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          prefs.getString('userfullname') != null
              ? IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark_border_rounded,
                  ),
                )
              : const SizedBox(
                  width: 30,
                ),
        ],
      ),
    );
  }
}
