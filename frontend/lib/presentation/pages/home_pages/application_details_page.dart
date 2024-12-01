
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/domain/models/application_model.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/presentation/pages/home_pages/preview_application_page.dart';
import 'package:khidma/presentation/widgets/home/job_details_page/job_card_description_req.dart';
import 'package:khidma/presentation/widgets/home/my_filled_button.dart';

class ApplicationDetailsPage extends StatelessWidget {
  const ApplicationDetailsPage({super.key, required this.applicationModel});
  final ApplicationModel applicationModel;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: -20,
              child: Opacity(
                opacity: .2,
                child: Image.asset(
                  'assets/images/photo.png',
                ),
              ),
            ),
            JobCardDescriptionAndRequirements(
              jobModel: applicationModel.job,
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 10,
                child: MyFilledButton(
                  label: 'Preview Application',
                  onPressed: () {
                    Get.to(
                      ()=> ApplicationPreviewScreen(
                        applicantID: applicationModel.applicationId,
                      ),
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}
