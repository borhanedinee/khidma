import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/home/job_requirements_controller.dart';
import 'package:khidma/presentation/shimmers/job_details_shimmers/job_details_shimmers.dart';
import 'package:khidma/presentation/widgets/home/job_details_page/job_description.dart';
import 'package:khidma/presentation/widgets/home/job_details_page/job_details_appbar.dart';
import 'package:khidma/presentation/widgets/home/job_details_page/job_details_card.dart';
import 'package:khidma/presentation/widgets/home/job_details_page/job_requirements.dart';
import 'package:khidma/presentation/widgets/home/my_filled_button.dart';

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
    jobRequirementsController.fetchJobRequirements(widget.jobModel.id);
    super.initState();
  }

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
            GetBuilder<JobRequirementsController>(
              builder: (controller) => SizedBox(
                height: size.height,
                width: size.width,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    // APP BAR
                    JobDetailsAppBar(jobModel: widget.jobModel),
                    const SizedBox(
                      height: 30,
                    ),
                    // JOB DETAILS CARD
                    JobDetailsCard(jobModel: widget.jobModel),

                    const SizedBox(
                      height: 20,
                    ),
                    controller.isFetchingJobRequirementsLoading
                        ? const JobDetailsPageShimmers()
                        : Column(
                            children: [
                              // DESCRIPTION

                              const JobDescription(),

                              const SizedBox(
                                height: 20,
                              ),

                              // JOB REQUIREMENTS
                              JobRequirements(),
                            ],
                          )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: MyFilledButton(
                label: 'A P P L Y    N O W',
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
