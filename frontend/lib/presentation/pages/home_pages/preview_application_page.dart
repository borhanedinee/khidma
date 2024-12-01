import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/constatnts/constants.dart';
import 'package:khidma/domain/models/application_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/home/preview_application_controller.dart';
import 'package:khidma/presentation/controllers/home/submitting_application_controller.dart';
import 'package:khidma/presentation/pages/home_pages/edit_application.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:khidma/presentation/widgets/home/job_details_page/job_details_card.dart';
import 'package:khidma/presentation/widgets/home/my_filled_button.dart';
import 'package:shimmer/shimmer.dart';

class ApplicationPreviewScreen extends StatefulWidget {
  const ApplicationPreviewScreen({
    super.key,
    required this.applicantID,
  });

  final int applicantID;

  @override
  State<ApplicationPreviewScreen> createState() =>
      _ApplicationPreviewScreenState();
}

class _ApplicationPreviewScreenState extends State<ApplicationPreviewScreen> {
  PreviewApplicationController previewApplicationController = Get.find();
  @override
  void initState() {
    previewApplicationController.fetchApplicationInfos(widget.applicantID);

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   previewApplicationController.fetchApplicationInfos(widget.applicantID);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreviewApplicationController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          body: SizedBox(
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const PreviewApplicationAppBar(),
                const SizedBox(
                  height: 30,
                ),
                controller.isFetchingApplicationInfos
                    ? _shimmerLoader()
                    : Column(
                        children: [
                          JobDetailsCard(
                              jobModel: controller.applicationModel!.job),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildDetailRow(
                                    "Full Name",
                                    controller
                                        .applicationModel!.applicationFullname),
                                _buildDetailRow(
                                    "Email",
                                    controller
                                        .applicationModel!.applicationEmail),
                                _buildDetailRow("Phone Number",
                                    '0${controller.applicationModel!.applicantPhone}'),
                                _buildDetailRow("Expected Salary",
                                    '${controller.applicationModel!.applicationExpectedSalary} DA'),
                                const SizedBox(height: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Resume",
                                      style: textTheme.bodyMedium!.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "The resume you have applied with",
                                      style: textTheme.bodySmall!.copyWith(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                _viewResumeCard(
                                    controller
                                        .applicationModel!.applicationResume,
                                    context),
                              ],
                            ),
                          ),
                        ],
                      ),
                const Spacer(),
                MyFilledButton(
                  backgroundColor: controller.isFetchingApplicationInfos
                      ? Colors.grey.shade300
                      : Theme.of(context).primaryColor,
                  label: 'Edit Application',
                  onPressed: () {
                    if (!controller.isFetchingApplicationInfos) {
                      Get.off(
                        () => EditApplicationPage(
                          applicationModel: controller.applicationModel!,
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _shimmerLoader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildShimmer(size.width, 240.0),
          _buildShimmer(size.width, 180.0),
          _buildShimmer(size.width, 50.0),
        ],
      ),
    );
  }

  Widget _buildShimmer(width, height) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.white,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Card _viewResumeCard(resume, context) {
    SubmittingApplicationController submittingApplicationController =
        Get.find();
    return Card(
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
        title: const Text('resumeee.pdf'),
        trailing: IconButton(
          icon: const Icon(Icons.visibility, color: Colors.blue),
          onPressed: () {
            // Implement logic to view the resume
            submittingApplicationController.downloadAndOpenResume(
              '$RESUME_URL/$resume',
              'resumeee.pdf',
              context,
            );
          },
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}

class PreviewApplicationAppBar extends StatelessWidget {
  const PreviewApplicationAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.navigate_before,
            ),
          ),
          Text(
            'Application Preview',
            style: textTheme.titleMedium!.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
        ],
      ),
    );
  }
}
