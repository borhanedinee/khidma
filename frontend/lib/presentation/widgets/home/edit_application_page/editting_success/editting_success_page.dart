import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/presentation/controllers/drawer_controller.dart';
import 'package:khidma/presentation/widgets/home/application_page/submission_success/submission_success_action_button.dart';
import 'package:khidma/presentation/widgets/home/application_page/submission_success/success_animation.dart';
import 'package:khidma/presentation/widgets/home/application_page/submission_success/success_message.dart';
import 'package:khidma/presentation/widgets/home/edit_application_page/editting_success/editting_success_action_button.dart';

class EdittingSuccessScreen extends StatelessWidget {
  EdittingSuccessScreen({super.key});

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
                const SuccessAnimation(),
                const SizedBox(height: 32),
                const SuccessMessage(),
                const SizedBox(height: 40),
                EdittingSuccessActionButtons(
                  onViewApplications: () {
                    // Navigate to ome page
                    // drawerController.navigateToPageFromExternal(PageType.applications);
                    Get.back();
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
