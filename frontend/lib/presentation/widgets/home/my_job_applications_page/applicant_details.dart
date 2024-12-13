import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/constatnts/constants.dart';
import 'package:khidma/domain/models/job_applicantion_model.dart';
import 'package:khidma/domain/models/user_model.dart';
import 'package:khidma/presentation/controllers/home/skills_controller.dart';
import 'package:khidma/presentation/pages/home_pages/messages_page.dart';
import 'package:khidma/presentation/services/format_date_time.dart';
import 'package:khidma/presentation/widgets/home/my_filled_button.dart';
import 'package:intl/intl.dart';

class ApplicantDetailsModal extends StatefulWidget {
  final JobApplicationModel jobApplication;

  const ApplicantDetailsModal({
    Key? key,
    required this.jobApplication,
  }) : super(key: key);

  @override
  State<ApplicantDetailsModal> createState() => _ApplicantDetailsModalState();
}

class _ApplicantDetailsModalState extends State<ApplicantDetailsModal> {
  SkillsController skillsController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      skillsController.fetchUserSkills(widget.jobApplication.applicantId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SkillsController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            // Avatar and Name
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                '$IMAGE_URL/${widget.jobApplication.applicantAvatar}',
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.jobApplication.applicantFullName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            controller.isFetchingUsrSkills
                ? const Text(
                    'fetching skills...',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                : controller.userSkills.isEmpty
                    ? const SizedBox()
                    : Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(
                          controller.userSkills.length,
                          (index) {
                            // List skillReversed =
                            //     controller.userSkills.reversed.toList();
                            final skill = controller.userSkills[index];
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 7,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                skill.skill,
                                style: TextStyle(fontSize: 12),
                              ),
                            );
                          },
                        ),
                      ),

            const SizedBox(height: 10),
            Divider(),
            const SizedBox(height: 10),

            Text(
              "Expected Salary: ${widget.jobApplication.expectedSalary} DA",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Text(
              "Applied ${formatDateTime(widget.jobApplication.createdAt.toLocal())}",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // View Resume
                IconButton(
                  onPressed: () {
                    controller.openResume(
                      '$RESUME_URL/${widget.jobApplication.applicantResume}',
                      '${widget.jobApplication.applicantFullName}_resume',
                      context,
                    );
                  },
                  icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
                  tooltip: "View Resume",
                ),
                // Call Applicant
                IconButton(
                  onPressed: () {
                    print('call applicant');
                    // Call Applicant
                    // launch("tel:${jobApplication.applicantPhone}");
                  },
                  icon: const Icon(Icons.call, color: Colors.green),
                  tooltip: "Call Applicant",
                ),
                // Email Applicant
                IconButton(
                  onPressed: () {
                    print('email applicant');

                    // Open Email Client
                    // launch("mailto:${jobApplication.applicantEmail}");
                  },
                  icon:
                      Icon(Icons.email, color: Theme.of(context).primaryColor),
                  tooltip: "Email Applicant",
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Start Conversation Button
            // ElevatedButton(
            //   onPressed: () {
            //     // Navigate to chat screen
            //     Navigator.pop(context); // Close Modal
            //     // Implement your navigation to chat screen logic here
            //   },
            //   child: const Text("Start Conversation"),
            //   style: ElevatedButton.styleFrom(
            //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            //   ),
            // ),
            MyFilledButton(
              label: 'Start Conversation',
              onPressed: () {
                final jobApplicant = widget.jobApplication;
                final user = UserModel(
                  id: jobApplicant.applicantId,
                  email: jobApplicant.applicantEmail,
                  phone: jobApplicant.applicantPhone,
                  password: 'password',
                  fullname: jobApplicant.applicantFullName,
                  avatar: jobApplicant.applicantAvatar,
                  isRecruiter: true,
                  resume: jobApplicant.applicantResume,
                );
                Get.to(
                  () => MessagesPage(
                      userToText: user,
                      needToUpdateUnreadMessages: false),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  
}
