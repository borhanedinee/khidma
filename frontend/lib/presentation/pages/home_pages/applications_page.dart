// applicants page
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/home/applications_controller.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:khidma/presentation/services/get_saved_user.dart';
import 'package:khidma/presentation/shimmers/application_page_shimmers/application_item_shimmer.dart';
import 'package:khidma/presentation/widgets/home/applicants_page/applicants_job_item.dart';
import 'package:khidma/presentation/widgets/home/my_app_bar.dart';

class ApplicationsPage extends StatefulWidget {
  const ApplicationsPage({super.key});

  @override
  State<ApplicationsPage> createState() => _ApplicationsPageState();
}

class _ApplicationsPageState extends State<ApplicationsPage> {
  ApplicationsController applicationController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      applicationController.fetchUserApplications(getSavedUser().id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApplicationsController>(
      builder: (controller) => SizedBox(
        height: size.height,
        child: Stack(
          children: [
            const MyAppBar(
              label: 'Applications',
            ),
            Positioned.fill(
              top: 80,
              child: Container(
                height: size.height - 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(
                      20,
                    ),
                  ),
                ),
                child: controller.isFetchingApplicationsLoading
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
                          const SizedBox(
                            height: 50,
                          ),
                          // in case , there are jobs added by user
                          Padding(
                            padding: const EdgeInsets.only(left: 14),
                            child: Text(
                              'View Jobs you have applied for',
                              style: textTheme.bodySmall!
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ...List.generate(
                            controller.applications.length,
                            (index) {
                              final applicationModel =
                                  controller.applications[index];
                              return ApplicationItem(
                                applicationModel: applicationModel,
                              );
                            },
                          )
                        ],
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
