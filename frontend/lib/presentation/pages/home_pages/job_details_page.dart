import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/home/job_requirements_controller.dart';
import 'package:khidma/presentation/pages/auth/login_page.dart';
import 'package:khidma/presentation/pages/home_pages/submitting_application_page.dart';
import 'package:khidma/presentation/shimmers/job_details_shimmers/job_details_shimmers.dart';
import 'package:khidma/presentation/widgets/home/job_details_page/job_card_description_req.dart';
import 'package:khidma/presentation/widgets/home/job_details_page/job_description.dart';
import 'package:khidma/presentation/widgets/home/job_details_page/job_details_appbar.dart';
import 'package:khidma/presentation/widgets/home/job_details_page/job_details_card.dart';
import 'package:khidma/presentation/widgets/home/job_details_page/job_requirements.dart';
import 'package:khidma/presentation/widgets/home/my_filled_button.dart';
import 'package:khidma/presentation/widgets/home/my_outlined_button.dart';

class JobDetailsPage extends StatefulWidget {
  const JobDetailsPage({super.key, required this.jobModel});

  final JobModel jobModel;

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  JobRequirementsController jobRequirementsController = Get.find();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      jobRequirementsController.fetchJobRequirements(widget.jobModel.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            JobCardDescriptionAndRequirements(
              jobModel: widget.jobModel,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: prefs.getString('userfullname') != null
                  ? MyFilledButton(
                      label: 'Apply Now',
                      onPressed: () {
                        Get.to(
                          ApplicationPage(jobModel: widget.jobModel),
                        );
                      },
                    )
                  : MyOutlinedButton(
                      label: 'Proceed To Sign Up',
                      onPressed: () {
                        Get.to(LoginPage());
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
