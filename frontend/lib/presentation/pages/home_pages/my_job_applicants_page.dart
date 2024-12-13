import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/home/applications_controller.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:khidma/presentation/services/authentication.dart';
import 'package:khidma/presentation/widgets/home/my_job_applications_page/job_application_item.dart';
import 'package:khidma/presentation/widgets/home/my_job_applications_page/my_job_applications_appbar.dart';
import 'package:khidma/presentation/widgets/home/my_job_applications_page/no_applications.dart';
import 'package:khidma/presentation/widgets/home/my_jobs_page/empty_jobs.dart';
import 'package:khidma/presentation/widgets/home/my_loading_item.dart';

class MyJobApplicantsPage extends StatefulWidget {
  const MyJobApplicantsPage({super.key, required this.jobid});

  final int jobid;

  @override
  State<MyJobApplicantsPage> createState() => _MyJobApplicantsPageState();
}

class _MyJobApplicantsPageState extends State<MyJobApplicantsPage> {
  ApplicationsController applicationsController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (AuthenticationService.isUserAuthenticated()) {
        applicationsController.fetchJobApplicants(widget.jobid);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: GetBuilder<ApplicationsController>(
            builder: (controller) => Column(
              children: [
                const MyJobApplicantsAppBar(),
                Expanded(
                  child: controller.isFetchingJobApplicantions
                      ? const LoadingItem(
                          loadingLabel: 'Fetching Applicants ...',
                          lottieAsset:
                              'assets/lottie/fetching_messages_loading.json',
                        )
                      : controller.jobApplications.isEmpty
                          ? const EmptyJobApplications()
                          : ListView.builder(
                              itemCount: controller.jobApplications.length,
                              itemBuilder: (context, index) {
                                final jobApplication =
                                    controller.jobApplications[index];
                                if (index == 0) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      _buildHeadline(Icons.receipt_long,
                                          'Recent Applications', context),
                                      JobApplicantItem(
                                        jobApplication: jobApplication,
                                      ),
                                    ],
                                  );
                                } else {
                                  return JobApplicantItem(
                                    jobApplication: jobApplication,
                                  );
                                }
                              }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildHeadline(IconData? icon, String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
      child: Row(
        children: [
          if (icon != null)
            Icon(
              icon,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
          if (icon != null) const SizedBox(width: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }
}
