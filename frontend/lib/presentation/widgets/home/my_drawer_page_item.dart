import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/presentation/controllers/drawer_controller.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class DrawePageItem extends StatelessWidget {
  final PageLabel label;

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
          if (label == PageLabel.logoutLabel) {
            controller.logOut();
          } else {
            Get.to(() => page);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              Icon(
                controller.iconForLabel(label),
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                controller.updateSelectedLabel(label),
                style: textTheme.bodySmall!.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
