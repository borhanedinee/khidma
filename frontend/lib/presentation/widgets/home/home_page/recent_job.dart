import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/constatnts/constants.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/home_pages/job_details_page.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class RecentJob extends StatefulWidget {
  final JobModel jobModel;
  const RecentJob({
    Key? key,
    required this.jobModel,
  }) : super(key: key);

  @override
  _RecentJobState createState() => _RecentJobState();
}

class _RecentJobState extends State<RecentJob>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(JobDetailsPage(jobModel: widget.jobModel));
      },
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Card(
            elevation: 1,
            shadowColor: Theme.of(context).primaryColor,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: size.width,
                  height: 130,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(.03),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: (size.width - 40) * .12,
                            child: Image.network(
                              '$IMAGE_URL/${widget.jobModel.companyLogo}',
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
                                  widget.jobModel.company,
                                  style: textTheme.titleMedium!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${widget.jobModel.title} - ${widget.jobModel.type}',
                                  overflow: TextOverflow.fade,
                                  style: textTheme.bodySmall!.copyWith(
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Text(
                          '\$${widget.jobModel.salary.toInt()} / Monthly',
                          style: textTheme.bodyMedium!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -80,
                  left: 0,
                  right: 0,
                  child: Opacity(
                    opacity: .1,
                    child: Image.asset('assets/images/photo.png'),
                  ),
                ),
              ],
            ),
          ),
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
