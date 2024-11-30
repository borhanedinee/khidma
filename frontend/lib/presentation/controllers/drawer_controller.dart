import 'package:get/get.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/main_page.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_page.dart';

enum PageType {
  home,
  profile,
  applications,
  bookmarks,
  notifications,
  settings,
}

enum PageLabel {
  homeLabel,
  profileLabel,
  applicationsLabel,
  bookmarksLabel,
  notificationsLabel,
  settingsLabel,
  logoutLabel,
}

class MyDrawerController extends GetxController {
  // initial state
  PageType _currentPage = PageType.home;
  String _selectedDrawerItem = 'H O M E';
  PageLabel _selectedLabel = PageLabel.homeLabel;

  PageType get currentPage => _currentPage;
  String get selectedDrawerItem => _selectedDrawerItem;
  PageLabel get selectedLabel => _selectedLabel;

  changeCurrentPage(PageType page) {
    _currentPage = page;
    update();
  }

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
  }

  // Method to handle navigation from external screens
  void navigateToPageFromExternal(PageType page) {
    _currentPage = page;
    update();
    // Navigate to main page with the new state
    Get.offAll(() => const MainPage());
  }

  String updateSelectedLabel(PageLabel pageLabel) {
    switch (pageLabel) {
      case PageLabel.profileLabel:
        return 'P R O F I L E';
      case PageLabel.applicationsLabel:
        return 'A P P L I C A N T S';
      case PageLabel.bookmarksLabel:
        return 'B O O K M A R K S';
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
}
