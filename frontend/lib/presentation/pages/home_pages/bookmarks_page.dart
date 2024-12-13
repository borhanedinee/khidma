// Chat page
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/domain/models/bookmark_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/home/bookmarks_controller.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:khidma/presentation/services/authentication.dart';
import 'package:khidma/presentation/shimmers/application_page_shimmers/application_item_shimmer.dart';
import 'package:khidma/presentation/widgets/home/bookmarks_page/bookmark_item.dart';
import 'package:khidma/presentation/widgets/home/my_app_bar.dart';
import 'package:khidma/presentation/widgets/home/my_top_shaddow.dart';
import 'package:khidma/presentation/widgets/home/proceed_to_login.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  BookmarksController bookmarksController = Get.find();

  @override
  void initState() {
    if (AuthenticationService.isUserAuthenticated()!) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        bookmarksController.bookmarks.clear();
        bookmarksController.fetchBookmarks(
          prefs.getInt('userid'),
        );
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookmarksController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          body: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                const MyAppBar(
                  label: 'Bookmarks',
                ),
                Positioned.fill(
                  top: 80,
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(
                              30,
                            ),
                          ),
                        ),
                        child: !AuthenticationService.isUserAuthenticated()
                            ? const ProceedToLogin()
                            : controller.isFetchingBookmarks
                                ? ListView(children: [
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 24),
                                      child: Text(
                                          'See your saved jobs in one place!'),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ...List.generate(3, (index) {
                                      return const ApplicationItemShimmer();
                                    }),
                                  ])
                                : controller.bookmarks.isEmpty
                                    ? Column(
                                        children: [
                                          const SizedBox(
                                            height: 100,
                                          ),
                                          SizedBox(
                                            height: 250,
                                            child: Lottie.asset(
                                              'assets/lottie/lottie_empty_bookmarks.json',
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            'Empty Bookmarks!',
                                            style: textTheme.headlineMedium!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24),
                                            child: Text(
                                              'You haven\'t saved anything yet. Start exploring and bookmark your favorite items to find them easily later!',
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: textTheme.bodyMedium!
                                                  .copyWith(
                                                color: Colors.black54,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : ListView(
                                        children: [
                                          const SizedBox(
                                            height: 40,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 24),
                                            child: Text(
                                                'See your saved jobs in one place!'),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ...List.generate(
                                              controller.bookmarks.length,
                                              (index) {
                                            BookmarkModel bookmarkModel =
                                                controller.bookmarks[index];
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: BookmarkItem(
                                                  bookmarkModel: bookmarkModel),
                                            );
                                          }),
                                        ],
                                      ),
                      ),
                      const MyTopShaddow()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
