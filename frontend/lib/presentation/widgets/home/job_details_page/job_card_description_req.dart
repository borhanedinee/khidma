
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/home/job_requirements_controller.dart';
import 'package:khidma/presentation/shimmers/job_details_shimmers/job_details_shimmers.dart';
import 'package:khidma/presentation/widgets/home/job_details_page/job_description.dart';
import 'package:khidma/presentation/widgets/home/job_details_page/job_details_appbar.dart';
import 'package:khidma/presentation/widgets/home/job_details_page/job_details_card.dart';
import 'package:khidma/presentation/widgets/home/job_details_page/job_requirements.dart';

class JobCardDescriptionAndRequirements extends StatelessWidget {
  const JobCardDescriptionAndRequirements({
    super.key,
    required this.jobModel,
  });

  final JobModel jobModel;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobRequirementsController>(
      builder: (controller) => SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            // APP BAR
            JobDetailsAppBar(jobModel: jobModel),

            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  // JOB DETAILS CARD
                  JobDetailsCard(jobModel: jobModel),

                  const SizedBox(
                    height: 30,
                  ),
                  controller.isFetchingJobRequirementsLoading
                      ? const JobDetailsPageShimmers()
                      : Column(
                          children: [

                            JobDescription(
                              jobModel: jobModel,
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            const JobRequirements(),

                            const SizedBox(
                              height: 100,
                            ),
                          ],
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
