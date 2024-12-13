import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/onboarding_controller.dart';
import 'package:khidma/presentation/pages/main_page.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class GetStartedPage extends StatelessWidget {
  GetStartedPage({super.key});
  final OnBoardingController _pageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 4, 46, 85),
        body: Column(
          children: [
            SizedBox(
              height: size.height * .1,
            ),
            Image.asset(
              'assets/images/photo.png',
              height: size.height * .5,
            ),
            SizedBox(
              height: size.height * .05,
            ),
            Column(
              children: [
                Text(
                  'Welcome to Khidma',
                  style: textTheme.titleLarge!.copyWith(color: Colors.yellow),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Search, Apply, and Start your First Job Now',
                  style: textTheme.bodySmall,
                  textAlign: TextAlign.center,
                )
              ],
            ),
            SizedBox(
              height: size.height * .05,
            ),
            Container(
              width: size.width - 40,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Get.off(
                    const MainPage(),
                  );
                  _pageController.currentPage = 1;
                },
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(
                    Color.fromARGB(255, 4, 46, 85),
                  ),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                        color: Colors.yellow,
                        width: .8,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
                child: const Text(
                  'Continue as a guest',
                  style: TextStyle(color: Colors.yellow),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
