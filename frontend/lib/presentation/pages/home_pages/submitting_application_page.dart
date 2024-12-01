// Notifications page
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/constatnts/constants.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/home/submitting_application_controller.dart';
import 'package:khidma/presentation/pages/home_pages/pdf_page.dart';
import 'package:khidma/presentation/services/get_saved_user.dart';
import 'package:khidma/presentation/widgets/home/application_page/application_form.dart';
import 'package:khidma/presentation/widgets/home/application_page/application_page_appbar.dart';
import 'package:khidma/presentation/widgets/home/my_filled_button.dart';

class ApplicationPage extends StatelessWidget {
  const ApplicationPage({super.key, required this.jobModel});

  final JobModel jobModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          child: Stack(
            children: [
              const ApplicationAppBar(
              ),
              Positioned.fill(
                top: 80,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(
                        30,
                      ),
                    ),
                  ),
                  child: Stack(
                    children: [
                      ApplicationForm(jobModel: jobModel),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 10,
                        child: GetBuilder<SubmittingApplicationController>(
                          builder: (controller) => MyFilledButton(
                                  label: controller.isSubmittingApplicationLoading? 'Submitting ...' : 'Submit Application' ,
                                  onPressed: () {
                                    _submitApplication(controller);
                                  },
                                ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submitApplication(SubmittingApplicationController controller) {
    if (controller.formKey.currentState!
        .validate()) {
      if (controller.applicantResume == null) {
        controller.isResumeSelected = false;
        controller.update();
      } else {
        controller.isResumeSelected = true;
        controller.update();
        // print('Application valid! ready to submit');
        // Get.to(PdfDownloader());
        int jobID = jobModel.id;
        int applicantID = getSavedUser().id;
        int expectedSalary = int.parse(
            controller
                .expectedSalaryController.text);
        String applicantFullname =
            controller.fullnameController.text;
        String applicantEmail =
            controller.emailController.text;
        int applicantPhone = int.parse(
            controller.phoneController.text);
        String applicantResume =
            controller.applicantResume!;
    
        controller.submitApplication(
          jobID,
          applicantID,
          expectedSalary,
          applicantFullname,
          applicantEmail,
          applicantPhone,
          applicantResume,
        );
      }
    } else {
      if (controller.applicantResume == null) {
        controller.isResumeSelected = false;
        controller.update();
      } else {
        controller.isResumeSelected = true;
        controller.update();
      }
    }
  }
}
