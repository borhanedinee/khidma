import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/constatnts/constants.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/home/bookmarks_controller.dart';
import 'package:khidma/presentation/pages/home_pages/job_details_page.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:khidma/presentation/services/format_date_time.dart';
import 'package:khidma/presentation/services/get_saved_user.dart';

class PopularJob extends StatefulWidget {
  final JobModel jobModel;
  final bool isLeftRadius;
  const PopularJob({
    Key? key,
    required this.jobModel,
    required this.isLeftRadius,
  }) : super(key: key);

  @override
  _PopularJobState createState() => _PopularJobState();
}

class _PopularJobState extends State<PopularJob>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookmarksController>(
      builder: (controller) => GestureDetector(
        onTap: () {
          Get.to(JobDetailsPage(jobModel: widget.jobModel));
        },
        child: SlideTransition(
          position: _slideAnimation,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: size.width - 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: .4),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Image.network('$IMAGE_URL/${widget.jobModel.companyLogo}',
                            height: 40),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.jobModel.title,
                              style: textTheme.bodyLarge!.copyWith(
                                color: Colors.black87,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              widget.jobModel.company,
                              style: textTheme.titleSmall!.copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            controller.toggleBookmark(
                              getSavedUser(),
                              widget.jobModel,
                            );
                          },
                          icon: Icon(
                            controller.isSelectedJobInBookamrks(
                                    prefs.getInt('userid'), widget.jobModel.id)
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: Theme.of(context).primaryColor,
                            size: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.jobModel.location}, Algeria',
                          style: textTheme.titleSmall!.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            _generateJobProperty(widget.jobModel.type),
                            const SizedBox(
                              width: 10,
                            ),
                            _generateJobProperty(widget.jobModel.category),
                            const SizedBox(
                              width: 10,
                            ),
                            _generateJobProperty(
                              formatDateTime(widget.jobModel.postedAt),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      height: 12,
                      thickness: .5,
                    ),
                    Row(
                      children: [
                        Text(
                          '+11 Applicants',
                          style: textTheme.bodySmall!.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '+${widget.jobModel.salary.toInt()} DA',
                                style: textTheme.titleLarge!.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: ' /month',
                                style: textTheme.bodySmall!.copyWith(
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _generateJobProperty(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey.shade300,
      ),
      child: Text(
        text.length > 10 ? '${text.substring(0, 10)}...' : text,
        style: textTheme.bodySmall!.copyWith(
            fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
