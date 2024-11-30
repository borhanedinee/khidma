import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/constatnts/constants.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/domain/models/user_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/home/application_controller.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:khidma/presentation/services/get_saved_user.dart';
import 'package:khidma/presentation/widgets/home/my_form_field.dart';
import 'package:khidma/presentation/widgets/home/profile_page/review_or_update_resume.dart';
import 'package:khidma/presentation/widgets/home/profile_page/upload_resume.dart';

class ApplicationForm extends StatefulWidget {
  const ApplicationForm({
    super.key,
    required this.jobModel,
  });

  final JobModel jobModel;

  @override
  State<ApplicationForm> createState() => _ApplicationFormState();
}

class _ApplicationFormState extends State<ApplicationForm>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _cardSlideAnimation;
  late Animation<double> _fadeAnimation;

  ApplicationController applicationController = Get.find();

  @override
  void initState() {
    // Initialize controllers with user data
    User user = getSavedUser();
    applicationController.emailController.text = user.email;
    applicationController.fullnameController.text = user.fullname;
    applicationController.phoneController.text = user.phone.toString();

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
    applicationController.emailController.dispose();
    applicationController.fullnameController.dispose();
    applicationController.phoneController.dispose();
    applicationController.expectedSalaryController.dispose();
    applicationController.formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApplicationController>(
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
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  color: Theme.of(context).primaryColor,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 40,
                        bottom: -70,
                        child: Opacity(
                          opacity: .2,
                          child: Image.asset(
                            'assets/images/photo.png',
                            height: 230,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: Image.network(
                                '$IMAGE_URL/${widget.jobModel.companyLogo}',
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
                                      color: Colors.white70,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    widget.jobModel.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'at ${widget.jobModel.company}',
                                    style: const TextStyle(
                                      color: Colors.white70,
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
                  controller.isUploadingFileLoading
                      ? const Center(
                          child: Text('Uploading Resume ...'),
                        )
                      : applicationController.isResumeDeleting
                          ? const Center(
                              child: Text('Deleting Resume ...'),
                            )
                          : prefs.getBool('dbgotresume')! &&
                                  prefs.getBool('userremoteresumeISNOTchanged')!
                              ? ReviewResume(
                                  fileName: 'resume',
                                  onReview: () {
                                    controller.downloadAndOpenResume(
                                      '$RESUME_URL/${prefs.getString('userremoteresume')}',
                                      'my_resume.pdf',
                                      context,
                                    );
                                  },
                                  onDelete: () {
                                    controller.deleteResume(getSavedUser().id);
                                  },
                                  onReplace: () {
                                    controller.pickSaveAndUploadFile();
                                  },
                                )
                              : prefs.getString('userlocalresume') != null
                                  ? ReviewResume(
                                      fileName: 'fileName',
                                      onDelete: () {
                                        controller
                                            .deleteResume(getSavedUser().id);
                                      },
                                      onReview: () =>
                                          controller.openSavedFile(),
                                      onReplace: () =>
                                          controller.pickSaveAndUploadFile(),
                                    )
                                  : UploadResume(
                                      onUploadResume: () =>
                                          controller.pickSaveAndUploadFile(),
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
