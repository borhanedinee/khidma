import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/presentation/pages/main_page.dart';
import 'package:khidma/presentation/widgets/home/submitt_application_page/submission_failure/submission_failured_action_buttons.dart';
import 'package:khidma/presentation/widgets/home/edit_application_page/editting_failure/editting_failure_action_buttons.dart';
import 'package:khidma/presentation/widgets/home/edit_application_page/editting_failure/editting_failure_animation.dart';
import 'package:khidma/presentation/widgets/home/edit_application_page/editting_failure/editting_failure_messages.dart';

class EdittingFailureScreen extends StatelessWidget {
  const EdittingFailureScreen({super.key});

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
                const EdittingFailureAnimation(),
                const SizedBox(height: 32),
                const EdittingFailureMessage(),
                const SizedBox(height: 40),
                EdittingFailureActionButtons(
                  onTryAgain: () {
                    // Navigate back to form
                    Get.back();
                  },
                  onBackToJobs: () {
                    // Navigate back to jobs list
                    Get.offAll(
                      const MainPage(),
                    );
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
