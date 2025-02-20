import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/constatnts/constants.dart';
import 'package:khidma/domain/models/application_model.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/home/edit_application_controller.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:khidma/presentation/widgets/home/edit_application_page/edit_resume.dart';
import 'package:khidma/presentation/widgets/home/my_form_field.dart';
import 'package:khidma/presentation/widgets/home/profile_page/review_or_update_resume.dart';
import 'package:khidma/presentation/widgets/home/profile_page/upload_resume.dart';

class EditApplicationForm extends StatefulWidget {
  const EditApplicationForm({
    super.key,
    required this.applicationModel,
  });

  final ApplicationModel applicationModel;

  @override
  State<EditApplicationForm> createState() => _EditApplicationFormState();
}

class _EditApplicationFormState extends State<EditApplicationForm>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _cardSlideAnimation;
  late Animation<double> _fadeAnimation;

  EditApplicationController applicationController = Get.find();

  @override
  void initState() {
    // Initialize controllers with user data
    applicationController.emailController.text =
        widget.applicationModel.applicationEmail;
    applicationController.fullnameController.text =
        widget.applicationModel.applicationFullname;
    applicationController.phoneController.text =
        '0${widget.applicationModel.applicantPhone}';
    applicationController.expectedSalaryController.text =
        '${widget.applicationModel.applicationExpectedSalary}';

    // Animation setup
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _cardSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    _animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    // Dispose controllers
    _animationController.dispose();
    applicationController.formKey.currentState?.dispose();
    // applicationController.formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final JobModel jobModel = widget.applicationModel.job;
    return GetBuilder<EditApplicationController>(
      builder: (controller) => ListView(
        children: [
          const SizedBox(height: 40),
          // Animated Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SlideTransition(
              position: _cardSlideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: .4),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Image.network(
                          '$IMAGE_URL/${jobModel.companyLogo}',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Applying for",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              jobModel.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'at ${jobModel.company}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          FadeTransition(
            opacity: _fadeAnimation,
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Please fill out the following details',
                      style: textTheme.bodySmall!.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Form
                  getHeader('Fullname'),
                  MyFormField(
                    onChanged: (value) =>
                        controller.updateIsSaveButtonClickable(
                      widget.applicationModel.applicationFullname,
                      widget.applicationModel.applicationEmail,
                      widget.applicationModel.applicantPhone,
                      widget.applicationModel.applicationExpectedSalary,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                        return 'Full name cannot contain special characters';
                      }
                      return null; // Valid input
                    },
                    hintText: 'Enter your fullname',
                    isPassword: false,
                    fieldController: applicationController.fullnameController,
                    textInputType: TextInputType.name,
                  ),
                  const SizedBox(height: 10),
                  getHeader('Email'),
                  MyFormField(
                    onChanged: (value) =>
                        controller.updateIsSaveButtonClickable(
                      widget.applicationModel.applicationFullname,
                      widget.applicationModel.applicationEmail,
                      widget.applicationModel.applicantPhone,
                      widget.applicationModel.applicationExpectedSalary,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    hintText: 'exemple@gmail.com',
                    isPassword: false,
                    fieldController: applicationController.emailController,
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10),
                  getHeader('Phone number'),
                  MyFormField(
                    onChanged: (value) =>
                        controller.updateIsSaveButtonClickable(
                      widget.applicationModel.applicationFullname,
                      widget.applicationModel.applicationEmail,
                      widget.applicationModel.applicantPhone,
                      widget.applicationModel.applicationExpectedSalary,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      if (!GetUtils.isPhoneNumber(value)) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                    hintText: '+213',
                    isPassword: false,
                    fieldController: applicationController.phoneController,
                    textInputType: TextInputType.phone,
                  ),
                  const SizedBox(height: 10),
                  getHeader('Expected Salary'),
                  MyFormField(
                    onChanged: (value) =>
                        controller.updateIsSaveButtonClickable(
                      widget.applicationModel.applicationFullname,
                      widget.applicationModel.applicationEmail,
                      widget.applicationModel.applicantPhone,
                      widget.applicationModel.applicationExpectedSalary,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your expected salary';
                      }
                      if (!RegExp(r'^\d+$').hasMatch(value)) {
                        return 'Salary must be a numeric value';
                      }
                      int salary = int.parse(value);
                      if (salary < 10000) {
                        return 'Salary must be at least 10000DA';
                      }
                      return null; // Valid input
                    },
                    hintText: '000000 DA',
                    isPassword: false,
                    fieldController:
                        applicationController.expectedSalaryController,
                    textInputType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      getHeader('Resume'),
                      controller.isResumeSelected
                          ? const SizedBox()
                          : Text(
                              'Please select a resume',
                              style: textTheme.bodySmall!.copyWith(
                                color: Colors.red,
                              ),
                            ),
                    ],
                  ),

                  // Shimmer Effect
                  prefs.getString('userresume') == null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 5),
                          child: Text(
                            'Make sure you upload your resume in PDF format.',
                            style: textTheme.bodySmall!
                                .copyWith(color: Colors.grey, fontSize: 10),
                          ),
                        )
                      : const SizedBox(),
                  controller.isEditingResumeLoading
                      ? const Center(
                          child: Text('Editing Resume ...'),
                        )
                      : EditResume(
                          fileName: 'resume',
                          onReview: () {
                            controller.openResume(
                              '$RESUME_URL/${widget.applicationModel.applicationResume}',
                              'my_resume.pdf',
                              context,
                            );
                          },
                          onReplace: () {
                            controller.pickSaveAndUploadFile(
                              widget.applicationModel.applicationId.toString(),
                            );
                          },
                        )
                ],
              ),
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Padding getHeader(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        label,
        style: textTheme.bodySmall!.copyWith(
          color: Colors.black,
        ),
      ),
    );
  }
}
