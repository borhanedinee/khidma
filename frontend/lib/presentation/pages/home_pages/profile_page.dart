import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/constatnts/constants.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/home/submitting_application_controller.dart';
import 'package:khidma/presentation/services/get_saved_user.dart';
import 'package:khidma/presentation/widgets/home/my_app_bar.dart';
import 'package:khidma/presentation/widgets/home/my_filled_button.dart';
import 'package:khidma/presentation/widgets/home/my_top_shaddow.dart';
import 'package:khidma/presentation/widgets/home/profile_page/profile_bar.dart';
import 'package:khidma/presentation/widgets/home/profile_page/review_or_update_resume.dart';
import 'package:khidma/presentation/widgets/home/profile_page/skills.dart';
import 'package:khidma/presentation/widgets/home/profile_page/upload_resume.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _applicationController;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideInAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation applicationController
    _applicationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Define fade-in and slide-up animations
    _fadeInAnimation = Tween<double>(
      begin: 0, // Start below
      end: 1, // Slide to original position
    ).animate(CurvedAnimation(
      parent: _applicationController,
      curve: Curves.easeIn,
    ));

    _slideInAnimation = Tween<Offset>(
      begin: const Offset(0, 2), // Start below
      end: Offset.zero, // Slide to original position
    ).animate(
      CurvedAnimation(
        parent: _applicationController,
        curve: Curves.easeOut,
      ),
    );

    // Start animations
    _applicationController.forward();
  }

  SubmittingApplicationController applicationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: size.height,
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _applicationController,
              builder: (context, child) {
                return const MyAppBar(
                  label: 'Profile',
                );
              },
            ),
            Positioned.fill(
              top: 80,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: ListView(
                      children: [
                        const SizedBox(height: 30),
                        // PROFILE BAR with Slide-in effect
                        FadeTransition(
                          opacity: _fadeInAnimation,
                          child: SlideTransition(
                            position: _slideInAnimation,
                            child: const ProfileBar(),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // UPLOAD RESUME with Slide-in effect
                        GetBuilder<SubmittingApplicationController>(
                          builder: (controller) => FadeTransition(
                            opacity: _fadeInAnimation,
                            child: SlideTransition(
                              position: _slideInAnimation,
                              child: applicationController
                                      .isUploadingFileLoading
                                  ? const Center(
                                      child: Text('Uploading Resume ...'),
                                    )
                                  : applicationController.isResumeDeleting
                                      ? const Center(
                                          child: Text('Deleting Resume ...'),
                                        )
                                      : prefs.getBool('dbgotresume')! &&
                                              prefs.getBool(
                                                  'userremoteresumeISNOTchanged')!
                                          ? ReviewResume(
                                              fileName: 'resume',
                                              onDelete: () =>
                                                  applicationController
                                                      .deleteResume(
                                                          getSavedUser().id),
                                              onReview: () {
                                                applicationController
                                                    .downloadAndOpenResume(
                                                        '$RESUME_URL/${prefs.getString('userremoteresume')}',
                                                        'my_resume.pdf',
                                                        context);
                                              },
                                              onReplace: () {
                                                applicationController
                                                    .pickSaveAndUploadFile();
                                              },
                                            )
                                          : prefs.getString(
                                                      'userlocalresume') !=
                                                  null
                                              ? ReviewResume(
                                                  fileName: 'fileName',
                                                  onDelete: () =>
                                                      applicationController
                                                          .deleteResume(
                                                              getSavedUser()
                                                                  .id),
                                                  onReview: () =>
                                                      applicationController
                                                          .openSavedFile(),
                                                  onReplace: () =>
                                                      applicationController
                                                          .pickSaveAndUploadFile(),
                                                )
                                              : UploadResume(
                                                  onUploadResume: () =>
                                                      applicationController
                                                          .pickSaveAndUploadFile(),
                                                ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        // SKILLS with Slide-in effect
                        FadeTransition(
                          opacity: _fadeInAnimation,
                          child: SlideTransition(
                            position: _slideInAnimation,
                            child: Skills(),
                          ),
                        ),
                        const SizedBox(height: 60),

                        // LOG OUT BUTTON with Slide-in effect
                        FadeTransition(
                          opacity: _fadeInAnimation,
                          child: SlideTransition(
                            position: _slideInAnimation,
                            child: MyFilledButton(
                              label: 'L O G O U T',
                              onPressed: () {
                                // Add your logout functionality here
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const MyTopShaddow(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _applicationController.dispose();
    super.dispose();
  }
}
