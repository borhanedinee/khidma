import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/presentation/controllers/drawer_controller.dart';
import 'package:khidma/presentation/pages/home_pages/home_page.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_page.dart';

class DrawePageItem extends StatelessWidget {
  final String label;

  final IconData? icon;

  final Widget page;

  const DrawePageItem({
    super.key,
    required this.label,
    this.icon,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyDrawerController>(
      builder: (controller) => GestureDetector(
        onTap: () {
          if (label != 'L O G O U T') {
            controller.changeCurrentPage(page);
            controller.changeSelectedDrawerItem(label);
            return;
          }
          Get.showSnackbar(
            const GetSnackBar(
              message: 'Logged Out Successfully',
            ),
          );
          Get.off(
            const OnBoardingPage(),
          );

          controller.changeSelectedDrawerItem('H O M E');
          controller.changeCurrentPage(const HomePage());
        },
        child: AnimatedContainer(
          duration: Durations.long1,
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: controller.selectedDrawerItem == label
                ? Theme.of(context).primaryColor.withOpacity(.3)
                : null,
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              Icon(
                icon,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                label,
                style: textTheme.bodySmall!.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
