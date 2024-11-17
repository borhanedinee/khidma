// Profile page
import 'package:flutter/material.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/widgets/home/my_app_bar.dart';

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
                child: const Column(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
