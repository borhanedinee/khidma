import 'package:flutter/material.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/drawer_controller.dart';
import 'package:khidma/presentation/pages/home_pages/applications_page.dart';
import 'package:khidma/presentation/pages/home_pages/bookmarks_page.dart';
import 'package:khidma/presentation/pages/home_pages/chats_page.dart';
import 'package:khidma/presentation/pages/home_pages/home_page.dart';
import 'package:khidma/presentation/pages/home_pages/my_jobs_pages.dart';
import 'package:khidma/presentation/pages/home_pages/notifications_page.dart';
import 'package:khidma/presentation/pages/home_pages/profile_page.dart';
import 'package:khidma/presentation/pages/home_pages/settings_page.dart';
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
            Container(
              child: SizedBox(
                width: 340,
                height: 230,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/logos/khidma_logo.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          Scaffold.of(context).closeDrawer();
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                        ),
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
              label: PageLabel.profileLabel,
              page: ProfilePage(),
            ),
            const DrawePageItem(
              label: PageLabel.myJobsLabel,
              page: MyJobsPage(),
            ),
            const DrawePageItem(
              label: PageLabel.applicationsLabel,
              page: ApplicationsPage(),
            ),
            const DrawePageItem(
              label: PageLabel.bookmarksLabel,
              page: BookmarksPage(),
            ),
            const DrawePageItem(
              label: PageLabel.chatsLabel,
              page: ChatsPage(),
            ),
            const DrawePageItem(
              label: PageLabel.settingsLabel,
              page: SettingsPage(),
            ),
            const Spacer(),
            const DrawePageItem(
              label: PageLabel.logoutLabel,
              page: OnBoardingOne(),
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
