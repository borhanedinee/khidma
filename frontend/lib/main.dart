import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/data/user_api.dart';
import 'package:khidma/presentation/controllers/auth/login_controller.dart';
import 'package:khidma/presentation/controllers/drawer_controller.dart';
import 'package:khidma/presentation/controllers/home/bookmarks_controller.dart';
import 'package:khidma/presentation/controllers/home/home_controller.dart';
import 'package:khidma/presentation/controllers/home/job_requirements_controller.dart';
import 'package:khidma/presentation/controllers/home/profile_controller.dart';
import 'package:khidma/presentation/controllers/onboarding_controller.dart';
import 'package:khidma/presentation/pages/home_pages/home_page.dart';
import 'package:khidma/presentation/pages/main_page.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
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
      themeMode: ThemeMode.dark,
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
      home: prefs.getString('userfullname') == null? const OnBoardingPage() : const MainPage(),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => OnBoardingController(), fenix: true);
        Get.lazyPut(() => MyDrawerController(), fenix: true);
        Get.lazyPut(() => ProfileController(), fenix: true);
        Get.lazyPut(() => HomeController(), fenix: true);
        Get.lazyPut(() => JobRequirementsController(), fenix: true);
        Get.lazyPut(() => BookmarksController(), fenix: true);
        Get.lazyPut(() => LoginController(userApi: UserApi()), fenix: true);
      }),
    );
  }
}
