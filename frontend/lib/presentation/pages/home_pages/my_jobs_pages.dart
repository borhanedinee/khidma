// Chat page
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/home/bookmarks_controller.dart';
import 'package:khidma/presentation/widgets/home/my_app_bar.dart';
import 'package:khidma/presentation/widgets/home/my_top_shaddow.dart';
import 'package:khidma/presentation/widgets/home/proceed_to_login.dart';

class MyJobsPage extends StatelessWidget {
  const MyJobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookmarksController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          body: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                const MyAppBar(
                  label: 'My Jobs',
                ),
                Positioned.fill(
                  top: 80,
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(
                              30,
                            ),
                          ),
                        ),
                        child: !prefs.getBool('isauthenticated')!
                            ? const ProceedToLogin()
                            : const Center(
                                child: Text(
                                  'Fetch Jobs For Corresponding User',
                                ),
                              ),
                      ),
                      const MyTopShaddow()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
