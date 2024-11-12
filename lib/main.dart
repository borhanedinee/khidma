import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/presentation/controllers/drawer_controller.dart';
import 'package:khidma/presentation/controllers/onboarding_controller.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_page.dart';

void main() {
  runApp(const Khidma());
}

late Size size;

class Khidma extends StatelessWidget {
  const Khidma({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            color: Colors.white,
          ),
          titleSmall: TextStyle(
            color: Colors.white,
          ),
          bodySmall: TextStyle(
            color: Colors.white70,
          ),
        ),
        fontFamily: 'Montserrat',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0A74DA),
          // seedColor:  Colors.redAccent,
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const OnBoardingPage(),
      initialBinding: BindingsBuilder(() {
        Get.put(OnBoardingController());
        Get.put(MyDrawerController());
      }),
    );
  }
}
