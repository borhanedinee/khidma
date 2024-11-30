import 'package:flutter/material.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/drawer_controller.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:khidma/presentation/widgets/home/my_drawer_page_item.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SizedBox(
        height: size.height * .7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: SizedBox(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Khidma',
                      style: textTheme.headlineLarge,
                    ),
                    IconButton(
                      onPressed: () {
                        Scaffold.of(context).closeDrawer();
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            const DrawePageItem(
              label: PageLabel.homeLabel,
              page: PageType.home,
            ),
            prefs.getString('userfullname') != null
                ? const DrawePageItem(
                    label: PageLabel.profileLabel,
                    page: PageType.profile,
                  )
                : const SizedBox(),
            const DrawePageItem(
              label: PageLabel.applicationsLabel,
              page: PageType.applications,
            ),
            const DrawePageItem(
              label: PageLabel.bookmarksLabel,
              page: PageType.bookmarks,
            ),
            const DrawePageItem(
              label: PageLabel.notificationsLabel,
              page: PageType.notifications,
            ),
            const DrawePageItem(
              label: PageLabel.settingsLabel,
              page: PageType.settings,
            ),
            const Spacer(),
            const DrawePageItem(
              label: PageLabel.logoutLabel,
              page: PageType.home,
            ),
            const SizedBox(
              height: 30,
            ),
            Text('Version 1.0',
                style: textTheme.bodySmall!.copyWith(color: Colors.grey)),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
