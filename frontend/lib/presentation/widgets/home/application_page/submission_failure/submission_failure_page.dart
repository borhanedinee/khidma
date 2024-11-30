import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/presentation/pages/main_page.dart';
import 'package:khidma/presentation/widgets/home/application_page/submission_failure/action_buttons.dart';
import 'package:khidma/presentation/widgets/home/application_page/submission_failure/failure_messages.dart';
import '../submission_failure/failure_animation.dart';

class SubmissionFailureScreen extends StatelessWidget {
  const SubmissionFailureScreen({super.key});

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
                const FailureAnimation(),
                const SizedBox(height: 32),
                const FailureMessage(),
                const SizedBox(height: 40),
                FailureActionButtons(
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
