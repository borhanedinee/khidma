import 'package:flutter/material.dart';
import 'package:khidma/constants.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class JobDetailsCard extends StatefulWidget {
  const JobDetailsCard({
    super.key,
    required this.jobModel,
  });

  final JobModel jobModel;

  @override
  State<JobDetailsCard> createState() => _JobDetailsCardState();
}

class _JobDetailsCardState extends State<JobDetailsCard>
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
              margin: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  // Background image
                  Positioned(
                    left: 40,
                    bottom: -70,
                    child: Opacity(
                      opacity: .2,
                      child: Image.asset(
                        'assets/images/photo.png',
                        height: 230,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      // Company logo
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Image.network(
                          '$IMAGE_URL/${widget.jobModel.companyLogo}',
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Job title
                      Text(
                        widget.jobModel.title,
                        style: textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Location (hardcoded for now)
                      Text(
                        'Algiers ( Remote )',
                        style: textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Job type and salary
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            child: Text(widget.jobModel.type),
                          ),
                          Text(
                            '${widget.jobModel.salary.toInt()} DA',
                            style: textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
