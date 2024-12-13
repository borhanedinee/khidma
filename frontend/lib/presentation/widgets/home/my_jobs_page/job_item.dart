import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/constatnts/constants.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/home_pages/my_job_applicants_page.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:khidma/presentation/services/format_date_time.dart';

class JobForRecruiterItem extends StatefulWidget {
  const JobForRecruiterItem({
    super.key,
    required this.jobModel,
  });

  final JobModel jobModel;

  @override
  State<JobForRecruiterItem> createState() => _JobForRecruiterItemState();
}

class _JobForRecruiterItemState extends State<JobForRecruiterItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Define fade and slide animations
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.7), // Start below
      end: Offset.zero, // Move to original position
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    // Start animations
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: SlideTransition(
            position: _slideAnimation,
            child: Container(
              width: size.width,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: .4),
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Image.network(
                        '$IMAGE_URL/${widget.jobModel.companyLogo}',
                        height: 40,
                      ),
                      const SizedBox(width: 20),
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
                          Row(
                            children: [
                              Text(
                                widget.jobModel.company,
                                style: textTheme.titleSmall!.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '${widget.jobModel.location}, Algeria',
                                style: textTheme.titleSmall!.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.fade,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 12,
                    thickness: .5,
                  ),
                  const SizedBox(
                    height: 10,
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
                                color: Colors.grey,
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
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ActionButton(
                        textColor: Colors.white,
                        text: 'Edit Job',
                        icon: Icons.edit,
                        onPressed: () {
                          // Navigate to edit job screen
                        },
                        color: Colors.blueGrey,
                      ),
                      ActionButton(
                        textColor: Colors.yellow,
                        text: 'View Applicants',
                        icon: Icons.group,
                        onPressed: () {
                          // Navigate to applicants screen
                          Get.to(
                            () => MyJobApplicantsPage(
                              jobid: widget.jobModel.id,
                            ),
                          );
                        },
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
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

class ActionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;

  const ActionButton({
    required this.text,
    required this.icon,
    required this.onPressed,
    required this.color,
    Key? key,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      icon: Icon(
        icon,
        color: textColor,
        size: 18,
      ),
      label: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      onPressed: onPressed,
    );
  }
}
