import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/chat/chats_controller.dart';
import 'package:khidma/presentation/pages/main_page.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_page.dart';

enum PageLabel {
  homeLabel,
  profileLabel,
  myJobsLabel,
  applicationsLabel,
  bookmarksLabel,
  chatsLabel,
  notificationsLabel,
  settingsLabel,
  logoutLabel,
}

enum PageIcon {
  homeIcon(
    Icons.home,
  ),
  profileIcon(Icons.person),
  myJobsIcon(Icons.window_rounded),
  applicationsIcon(Icons.work),
  bookmarksIcon(Icons.bookmark),
  chatsIcon(Icons.chat),
  notificationsIcon(Icons.notifications),
  settingsIcon(Icons.settings),
  logoutIcon(Icons.logout);

  final IconData icon;
  const PageIcon(this.icon);
}

class MyDrawerController extends GetxController {
  final SocketService socketService = Get.find();
  // initial state
  String _selectedDrawerItem = 'H O M E';
  PageLabel _selectedLabel = PageLabel.homeLabel;

  String get selectedDrawerItem => _selectedDrawerItem;
  PageLabel get selectedLabel => _selectedLabel;

  changeSelectedDrawerItem(PageLabel pageLabel) {
    if (pageLabel == PageLabel.logoutLabel) {
      logOut();
      return;
    }
    _selectedLabel = pageLabel;
    _selectedDrawerItem = updateSelectedLabel(pageLabel);
    update();
  }

  logOut() {
    prefs.clear();
    Get.offAll(
      const OnBoardingPage(),
    );
    Get.showSnackbar(
      const GetSnackBar(
        message: 'Logged Out Successfully',
      ),
    );
    prefs.setBool('isauthenticated', false);
    print('disconnecting socket...');
    // socketService.disconnect();
  }

  String updateSelectedLabel(PageLabel pageLabel) {
    switch (pageLabel) {
      case PageLabel.profileLabel:
        return 'P R O F I L E';
      case PageLabel.myJobsLabel:
        return 'M Y   J O B S';
      case PageLabel.applicationsLabel:
        return 'A P P L I C A T I O N S';
      case PageLabel.bookmarksLabel:
        return 'B O O K M A R K S';
      case PageLabel.chatsLabel:
        return 'C H A T S';
      case PageLabel.notificationsLabel:
        return 'N O T I F I C A T I O N S';
      case PageLabel.settingsLabel:
        return 'S E T T I N G S';
      case PageLabel.logoutLabel:
        return 'L O G O U T';

      default:
        return 'H O M E';
    }
  }

  IconData get icon => iconForLabel(_selectedLabel);

  IconData iconForLabel(PageLabel label) {
    switch (label) {
      case PageLabel.homeLabel:
        return PageIcon.homeIcon.icon;
      case PageLabel.profileLabel:
        return PageIcon.profileIcon.icon;
      case PageLabel.myJobsLabel:
        return PageIcon.myJobsIcon.icon;
      case PageLabel.applicationsLabel:
        return PageIcon.applicationsIcon.icon;
      case PageLabel.bookmarksLabel:
        return PageIcon.bookmarksIcon.icon;
      case PageLabel.chatsLabel:
        return PageIcon.chatsIcon.icon;
      case PageLabel.notificationsLabel:
        return PageIcon.notificationsIcon.icon;
      case PageLabel.settingsLabel:
        return PageIcon.settingsIcon.icon;
      case PageLabel.logoutLabel:
        return PageIcon.logoutIcon.icon;
    }
  }
}
