// applicants page
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/home/applications_controller.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:khidma/presentation/services/get_saved_user.dart';
import 'package:khidma/presentation/shimmers/application_page_shimmers/application_item_shimmer.dart';
import 'package:khidma/presentation/widgets/home/applications_page/applicants_job_item.dart';
import 'package:khidma/presentation/widgets/home/my_app_bar.dart';
import 'package:khidma/presentation/widgets/home/my_top_shaddow.dart';
import 'package:khidma/presentation/widgets/home/proceed_to_login.dart';
import 'package:lottie/lottie.dart';

class ApplicationsPage extends StatefulWidget {
  const ApplicationsPage({super.key});

  @override
  State<ApplicationsPage> createState() => _ApplicationsPageState();
}

class _ApplicationsPageState extends State<ApplicationsPage> {
  ApplicationsController applicationController = Get.find();

  @override
  void initState() {
    // applicationController.applications.clear();
    // applicationController.update();
    if (prefs.getBool('isauthenticated')!) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        applicationController.fetchUserApplications(
          getSavedUser().id,
        );
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApplicationsController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          body: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                const MyAppBar(
                  label: 'Applications',
                ),
                Positioned.fill(
                  top: 80,
                  child: Stack(
                    children: [
                      Container(
                        height: size.height - 100,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(
                              30,
                            ),
                          ),
                        ),
                        child: !prefs.getBool('isauthenticated')!
                            ? const ProceedToLogin()
                            : controller.isFetchingApplicationsLoading
                                ? ListView(children: [
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    ...List.generate(
                                      4,
                                      (index) => const ApplicationItemShimmer(),
                                    )
                                  ])
                                : ListView(
                                    children: [
                                      controller.applications.isEmpty &&
                                              !controller
                                                  .isFetchingApplicationsLoading
                                          ? Column(
                                              children: [
                                                const SizedBox(
                                                  height: 100,
                                                ),
                                                SizedBox(
                                                  height: 250,
                                                  child: Lottie.asset(
                                                    'assets/lottie/lottie_empty_bookmarks.json',
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                Text(
                                                  'No Applications Yet!',
                                                  style: textTheme
                                                      .headlineMedium!
                                                      .copyWith(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 24),
                                                  child: Text(
                                                    'You haven’t applied for any jobs yet. Start exploring opportunities and send in your applications to land your dream role!',
                                                    textAlign: TextAlign.center,
                                                    style: textTheme.bodyMedium!
                                                        .copyWith(
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 50,
                                                ),
                                                // in case , there are jobs added by user
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 24),
                                                  child: Text(
                                                    'View Jobs you have applied for',
                                                    style: textTheme.bodySmall!
                                                        .copyWith(
                                                            color:
                                                                Colors.black),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                ...List.generate(
                                                  controller
                                                      .applications.length,
                                                  (index) {
                                                    final applicationModel =
                                                        controller.applications[
                                                            index];
                                                    return ApplicationItem(
                                                      applicationModel:
                                                          applicationModel,
                                                    );
                                                  },
                                                )
                                              ],
                                            ),
                                    ],
                                  ),
                      ),
                      const MyTopShaddow(),
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
