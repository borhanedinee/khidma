// Notifications page
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/domain/models/application_model.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/home/edit_application_controller.dart';
import 'package:khidma/presentation/services/get_saved_user.dart';
import 'package:khidma/presentation/widgets/home/application_page/application_page_appbar.dart';
import 'package:khidma/presentation/widgets/home/edit_application_page/edit_application_appbar.dart';
import 'package:khidma/presentation/widgets/home/edit_application_page/edit_application_form.dart';
import 'package:khidma/presentation/widgets/home/my_filled_button.dart';

class EditApplicationPage extends StatelessWidget {
  const EditApplicationPage({super.key, required this.applicationModel});

  final ApplicationModel applicationModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          child: Stack(
            children: [
              EditApplicationAppBar(
                applicantID: applicationModel.applicationId,
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
                      EditApplicationForm(
                        applicationModel: applicationModel,
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 10,
                        child: GetBuilder<EditApplicationController>(
                          builder: (controller) => MyFilledButton(
                            backgroundColor: controller.isSaveButtonClickable
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                            label: controller.isEditingApplicationLoading
                                ? 'Saving ...'
                                : 'Save Application',
                            onPressed: () {
                              if (controller.isSaveButtonClickable) {
                                _editApplication(
                                  controller,
                                  applicationModel.applicationId.toString(),
                                );
                              }
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

  void _editApplication(
      EditApplicationController controller, String applicationID) {
    if (controller.formKey.currentState!.validate()) {
      controller.isResumeSelected = true;
      controller.update();
      // print('Application valid! ready to submit');
      // Get.to(PdfDownloader());
      int expectedSalary = int.parse(controller.expectedSalaryController.text);
      String applicantFullname = controller.fullnameController.text;
      String applicantEmail = controller.emailController.text;
      int applicantPhone = int.parse(controller.phoneController.text);

      controller.editApplication(
        applicantFullname,
        applicantEmail,
        applicantPhone,
        expectedSalary,
        applicationID,
      );
    }
  }
}
