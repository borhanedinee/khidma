import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/presentation/controllers/drawer_controller.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:khidma/presentation/widgets/home/my_drawer.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;

    return GetBuilder<MyDrawerController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          body: controller.currentPage,
          drawer: const MyDrawer(),
        ),
      ),
    );
  }
}
