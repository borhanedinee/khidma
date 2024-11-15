import 'package:flutter/material.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/home_pages/applicants_page.dart';
import 'package:khidma/presentation/pages/home_pages/chats_page.dart';
import 'package:khidma/presentation/pages/home_pages/home_page.dart';
import 'package:khidma/presentation/pages/home_pages/logout_page.dart';
import 'package:khidma/presentation/pages/home_pages/notifications_page.dart';
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
              label: 'H O M E',
              icon: Icons.home,
              page: HomePage(),
            ),
            const DrawePageItem(
              label: 'A P P L I C A N T S',
              icon: Icons.groups,
              page: ApplicantsPage(),
            ),
            const DrawePageItem(
              label: 'C H A T S',
              icon: Icons.chat,
              page: ChatPage(),
            ),
            const DrawePageItem(
              label: 'N O T I F I C A T I O N S',
              icon: Icons.notifications,
              page: NotificationsPage(),
            ),
            const DrawePageItem(
              label: 'S E T T I N G S',
              icon: Icons.settings,
              page: SettingsPage(),
            ),
            const Spacer(),
            const DrawePageItem(
              label: 'L O G O U T',
              icon: Icons.logout,
              page: LogoutPage(),
            ),
            const SizedBox(
              height: 30,
            ),
             Text(
              'Version 1.0',
              style: textTheme.bodySmall!.copyWith(color: Colors.grey)
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
