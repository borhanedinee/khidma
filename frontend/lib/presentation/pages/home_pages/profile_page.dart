// Profile page
import 'package:flutter/material.dart';
import 'package:khidma/constants.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:khidma/presentation/widgets/home/my_app_bar.dart';
import 'package:khidma/presentation/widgets/home/my_filled_button.dart';
import 'package:khidma/presentation/widgets/home/profile_page/profile_bar.dart';
import 'package:khidma/presentation/widgets/home/profile_page/skills.dart';
import 'package:khidma/presentation/widgets/home/profile_page/upload_resume.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: size.height,
        child: Stack(
          children: [
            const MyAppBar(
              label: 'Profile',
            ),
            Positioned.fill(
              top: 80,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(
                      30,
                    ),
                  ),
                ),
                child: Expanded(
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                  
                      // PROFILE BAR
                      const ProfileBar(),
                  
                      const SizedBox(
                        height: 30,
                      ),
                  
                      // UPLOAD RESUME
                      const UploadResume(),
                  
                      const SizedBox(
                        height: 30,
                      ),
                  
                      // SKILLS
                      Skills(),
                  
                      SizedBox(
                        height: 60,
                      ),
                  
                      // LOG OUT
                      MyFilledButton(label: 'L O G O U T', onPressed: () {
                        
                      },)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
