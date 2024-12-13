// Chat page
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/home/bookmarks_controller.dart';
import 'package:khidma/presentation/controllers/home/jobs_of_recruiter_controller.dart';
import 'package:khidma/presentation/services/authentication.dart';
import 'package:khidma/presentation/services/get_saved_user.dart';
import 'package:khidma/presentation/shimmers/my_jobs_page_shimmers/loading_my_jobs_shimmers.dart';
import 'package:khidma/presentation/widgets/home/job_details_page/job_details_card.dart';
import 'package:khidma/presentation/widgets/home/my_app_bar.dart';
import 'package:khidma/presentation/widgets/home/my_jobs_page/empty_jobs.dart';
import 'package:khidma/presentation/widgets/home/my_jobs_page/job_item.dart';
import 'package:khidma/presentation/widgets/home/my_top_shaddow.dart';
import 'package:khidma/presentation/widgets/home/proceed_to_login.dart';
import 'package:lottie/lottie.dart';

class MyJobsPage extends StatefulWidget {
  const MyJobsPage({super.key});

  @override
  State<MyJobsPage> createState() => _MyJobsPageState();
}

class _MyJobsPageState extends State<MyJobsPage> {
  JobsOfRecruiterController jobsOfRecruiterController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (AuthenticationService.isUserAuthenticated()) {
        jobsOfRecruiterController.fetchRecruiterJobs(getSavedUser().id);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobsOfRecruiterController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          body: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                const MyAppBar(
                  label: 'My Jobs',
                ),
                Positioned.fill(
                  top: 80,
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(
                              30,
                            ),
                          ),
                        ),
                        child: !AuthenticationService.isUserAuthenticated()
                            ? const ProceedToLogin()
                            : controller.isFetchingJobsForRecruiter
                                ? const LoadingMyJobsShimmer()
                                : controller.recruiterJobs.isEmpty
                                    ? const EmptyJobsForRecruiter()
                                    : ListView.builder(
                                        itemCount:
                                            controller.recruiterJobs.length,
                                        itemBuilder: (context, index) {
                                          final job =
                                              controller.recruiterJobs[index];

                                          if (index == 0) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 40,
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 24,
                                                  ),
                                                  child: Text(
                                                    'Jobs you have posted',
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                JobForRecruiterItem(
                                                  jobModel: job,
                                                ),
                                              ],
                                            );
                                          } else {
                                            return JobForRecruiterItem(
                                              jobModel: job,
                                            );
                                          }
                                        },
                                      ),
                      ),
                      const MyTopShaddow()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
