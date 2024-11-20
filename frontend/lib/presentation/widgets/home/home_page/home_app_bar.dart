import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/constants.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/drawer_controller.dart';
import 'package:khidma/presentation/pages/auth/login_page.dart';
import 'package:khidma/presentation/pages/home_pages/profile_page.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      backgroundColor: Theme.of(context).primaryColor,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Search \nFind & Apply',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
          ],
        ),
      ),
      title: prefs.getString('userfullname') == null
          ? null
          : Text('Hi, ${(prefs.getString('userfullname')!.split(' ').last)}'),
      actions: [
        prefs.getString('userfullname') == null
            ? TextButton(
                onPressed: () {
                  Get.to(
                    LoginPage(),
                  );
                },
                child: const Text(
                  'Join us',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              )
            : GetBuilder<MyDrawerController>(
                builder: (controller) => InkWell(
                  onTap: () {
                    controller.changeCurrentPage(const ProfilePage());
                    controller.changeSelectedDrawerItem('P R O F I L E');
                  },
                  child: CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(
                        '$IMAGE_URL/${prefs.getString('useravatar')}'),
                  ),
                ),
              ),
        const SizedBox(
          width: 20,
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Container(
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: textTheme.bodySmall!.copyWith(color: Colors.grey),
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.settings),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
