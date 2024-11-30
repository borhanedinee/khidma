import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/presentation/controllers/drawer_controller.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class DrawePageItem extends StatelessWidget {
  final PageLabel label;

  final IconData? icon;

  final PageType page;

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
          controller.changeCurrentPage(page);
          controller.changeSelectedDrawerItem(label);
        },
        child: AnimatedContainer(
          duration: Durations.long1,
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: controller.selectedLabel == label
                ? Theme.of(context).primaryColor.withOpacity(.3)
                : null,
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              Icon(
                controller.iconForLabel(label),
                color: Colors.black,
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
