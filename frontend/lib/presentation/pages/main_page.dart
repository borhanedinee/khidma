import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/presentation/controllers/drawer_controller.dart';
import 'package:khidma/presentation/widgets/home/my_drawer.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
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
