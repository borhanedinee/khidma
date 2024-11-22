import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/constants.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/home_pages/job_details_page.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

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
    return GestureDetector(
      onTap: () {
        Get.to(JobDetailsPage(jobModel: widget.jobModel));
      },
      child: SlideTransition(
        position: _slideAnimation,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.only(left: 20),
                width: size.width - 100,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
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
                        Text(
                          widget.jobModel.company,
                          style: textTheme.titleMedium!.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.jobModel.title,
                          style: textTheme.titleMedium!.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.jobModel.type,
                          style: textTheme.bodySmall!.copyWith(
                            color: Colors.black38,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '${widget.jobModel.salary.toInt()} DA',
                          style: textTheme.bodyMedium!.copyWith(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton.filled(
                          onPressed: () {
                            Get.to(JobDetailsPage(jobModel: widget.jobModel));
                          },
                          icon: const Icon(Icons.navigate_next),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: -50,
              left: 0,
              right: 0,
              child: Opacity(
                opacity: .1,
                child: Image.asset(
                  'assets/images/photo.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
