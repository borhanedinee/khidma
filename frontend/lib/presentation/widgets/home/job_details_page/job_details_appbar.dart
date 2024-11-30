import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/home/bookmarks_controller.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:khidma/presentation/services/get_saved_user.dart';

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
            'Job Details',
            style: textTheme.titleMedium!.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          prefs.getString('userfullname') != null
              ? GetBuilder<BookmarksController>(
                  builder: (controller) => IconButton(
                    onPressed: () {
                      controller.toggleBookmark(getSavedUser(), jobModel , );
                    },
                    icon: Icon(controller.isSelectedJobInBookamrks(
                            prefs.getInt('userid'), jobModel.id)
                        ? Icons.bookmark
                        : Icons.bookmark_border),
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
