// Chat page
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/domain/models/bookmark_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/home/bookmarks_controller.dart';
import 'package:khidma/presentation/widgets/home/bookmarks_page/bookmark_item.dart';
import 'package:khidma/presentation/widgets/home/my_app_bar.dart';
import 'package:khidma/presentation/widgets/home/my_top_shaddow.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bookmarksController.fetchBookmarks(
        prefs.getInt('userid'),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookmarksController>(
      builder: (controller) => SizedBox(
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
                    child: controller.isFetchingBookmarks
                        ? ListView(children: [
                            const SizedBox(
                              height: 40,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 24),
                              child: Text('See your saved jobs in one place!'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ...List.generate(3, (index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade200,
                                highlightColor: Colors.grey.shade50,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 10, left: 12, right: 12),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  width: size.width,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              );
                            }),
                          ])
                        : controller.bookmarks.isEmpty
                            ? const Center(
                                child: Text('Empty bookmarks'),
                              )
                            : ListView(children: [
                                const SizedBox(
                                  height: 40,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 24),
                                  child:
                                      Text('See your saved jobs in one place!'),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ...List.generate(controller.bookmarks.length,
                                    (index) {
                                  BookmarkModel bookmarkModel =
                                      controller.bookmarks[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: BookmarkItem(
                                        bookmarkModel: bookmarkModel),
                                  );
                                }),
                              ]),
                  ),
                  const MyTopShaddow()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
