import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/presentation/controllers/drawer_controller.dart';
import 'package:khidma/presentation/pages/home_pages/application_details_page.dart';
import 'package:khidma/presentation/pages/home_pages/preview_application_page.dart';
import 'package:khidma/presentation/widgets/home/application_page/submission_success/submission_success_action_button.dart';
import 'package:khidma/presentation/widgets/home/application_page/submission_success/success_animation.dart';
import 'package:khidma/presentation/widgets/home/application_page/submission_success/success_message.dart';
import 'package:khidma/presentation/widgets/home/edit_application_page/editting_success/editting_success_action_button.dart';
import 'package:khidma/presentation/widgets/home/edit_application_page/editting_success/editting_success_animation.dart';
import 'package:khidma/presentation/widgets/home/edit_application_page/editting_success/editting_success_message.dart';

class EdittingSuccessScreen extends StatelessWidget {
  EdittingSuccessScreen({super.key, required this.applicationID});
  final int applicationID;

  final MyDrawerController drawerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const EdittingSuccessAnimation(),
                const SizedBox(height: 32),
                const EdittingSuccessMessage(),
                const SizedBox(height: 40),
                EdittingSuccessActionButtons(
                  onViewApplications: () {
                    // Navigate to ome page
                    // drawerController.navigateToPageFromExternal(PageType.applications);
                    Get.offUntil(
                      GetPageRoute(
                        page: () => ApplicationPreviewScreen(
                            applicantID: applicationID),
                      ),
                      (route) {
                        if (route is GetPageRoute) {
                          return route.page == () => ApplicationDetailsPage;
                        }
                        return true;
                      },
                    );
                  },
                  onBackToJobs: () {
                    // Navigate back to jobs list
                    // drawerController.navigateToPageFromExternal(PageType.home);
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
