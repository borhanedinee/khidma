import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/auth/login_controller.dart';
import 'package:khidma/presentation/controllers/drawer_controller.dart';
import 'package:khidma/presentation/pages/home_pages/applicants_page.dart';
import 'package:khidma/presentation/pages/home_pages/bookmarks_page.dart';
import 'package:khidma/presentation/pages/home_pages/home_page.dart';
import 'package:khidma/presentation/pages/home_pages/notifications_page.dart';
import 'package:khidma/presentation/pages/home_pages/profile_page.dart';
import 'package:khidma/presentation/pages/home_pages/settings_page.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:khidma/presentation/widgets/home/my_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  LoginController loginController = Get.find();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (prefs.getString('useremail') != null &&
          prefs.getString('userpassword') != null) {
        loginController.loginFromSharedPreference(
            prefs.getString('useremail'), prefs.getString('userpassword'));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;

    return GetBuilder<MyDrawerController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          body: _buildBody(controller.currentPage),
          drawer: const MyDrawer(),
        ),
      ),
    );
  }

  Widget _buildBody(PageType currentPage) {
    switch (currentPage) {
      case PageType.profile:
        return const ProfilePage();
      case PageType.applications:
        return const ApplicantsPage();
      case PageType.bookmarks:
        return const BookmarksPage();
      case PageType.notifications:
        return const NotificationsPage();
      case PageType.settings:
        return const SettingsPage();
      default:
        return HomePage();
    }
  }
}
