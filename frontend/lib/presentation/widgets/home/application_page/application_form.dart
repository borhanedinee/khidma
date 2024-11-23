import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/constants.dart';
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
  late TextEditingController emailController;
  late TextEditingController fullnameController;
  late TextEditingController phoneController;
  late TextEditingController expectedSalaryController;

  late AnimationController _animationController;
  late Animation<Offset> _cardSlideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    // Controllers for text fields
    emailController = TextEditingController();
    fullnameController = TextEditingController();
    phoneController = TextEditingController();
    expectedSalaryController = TextEditingController();

    // Initialize controllers with user data
    User user = getSavedUser();
    emailController.text = user.email;
    fullnameController.text = user.fullname;
    phoneController.text = '0777777733';
    expectedSalaryController.text = '100000';

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
    emailController.dispose();
    fullnameController.dispose();
    phoneController.dispose();
    expectedSalaryController.dispose();
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
                    fieldController: fullnameController,
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
                    fieldController: emailController,
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
                    fieldController: phoneController,
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
                    fieldController: expectedSalaryController,
                    textInputType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  getHeader('Resume'),

                  // Shimmer Effect
                  prefs.getString('userresume') == null
                      ?
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                    child: Text(
                      'Make sure you upload your resume in PDF format.',
                      style: textTheme.bodySmall!
                          .copyWith(color: Colors.grey, fontSize: 10),
                    ),
                  ) : SizedBox(),
                  prefs.getString('userresume') == null
                      ? UploadResume(
                        onUploadResume: () => controller.pickAndSaveFile() ,
                      )
                      : ReviewResume(
                          fileName: 'fileName',
                          onReview: () => controller.openSavedFile(),
                          onReplace: () => controller.pickAndSaveFile(),
                        ),
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
