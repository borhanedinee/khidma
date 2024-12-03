import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/constatnts/constants.dart';
import 'package:khidma/domain/models/bookmark_model.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/home/bookmarks_controller.dart';
import 'package:khidma/presentation/pages/home_pages/job_details_page.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:khidma/presentation/services/get_saved_user.dart';

class BookmarkItem extends StatefulWidget {
  final BookmarkModel bookmarkModel;

  const BookmarkItem({
    super.key,
    required this.bookmarkModel,
  });

  @override
  State<BookmarkItem> createState() => _BookmarkItemState();
}

class _BookmarkItemState extends State<BookmarkItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Animation Controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Slide and Fade Animations
    _slideAnimation = Tween<Offset>(
      begin: const Offset(2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.forward(); // Start entrance animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    JobModel jobModel = widget.bookmarkModel.job;

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: GestureDetector(
          onTap: () {
            Get.to(JobDetailsPage(jobModel: widget.bookmarkModel.job));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Card(
              child: Stack(
                children: [
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      width: size.width,
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: size.width - 40,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: (size.width - 40) * .12,
                                  child: Image.network(
                                    '$IMAGE_URL/${jobModel.companyLogo}',
                                    scale: 1.0,
                                    height: 40,
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: (size.width - 40) * .55,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        jobModel.company,
                                        style: textTheme.titleMedium!.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${jobModel.title} - ${jobModel.type}',
                                        overflow: TextOverflow.fade,
                                        style: textTheme.bodySmall!.copyWith(
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: (size.width - 40) * .2,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Text(
                              '\$${jobModel.salary.toInt()} / Monthly',
                              style: textTheme.bodyMedium!.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: -80,
                    child: Opacity(
                      opacity: .05,
                      child: Image.asset(
                        'assets/images/photo.png',
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: GetBuilder<BookmarksController>(
                      builder: (controller) => IconButton(
                        onPressed: () {
                          // Trigger a small scale animation on tap
                          _controller.reverse().then((_) {
                            controller.toggleBookmark(
                              getSavedUser(),
                              jobModel,
                            );
                            _controller.forward();
                          });
                        },
                        icon: AnimatedScale(
                          scale: controller.isSelectedJobInBookamrks(
                                  prefs.getInt('userid'), jobModel.id)
                              ? 1.2
                              : 1.0,
                          duration: const Duration(milliseconds: 200),
                          child: Icon(
                            controller.isSelectedJobInBookamrks(
                                    prefs.getInt('userid'), jobModel.id)
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
