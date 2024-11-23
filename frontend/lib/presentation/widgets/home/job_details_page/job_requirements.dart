import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/domain/models/job_requirement_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/home/job_requirements_controller.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class JobRequirements extends StatefulWidget {
  const JobRequirements({super.key});

  @override
  State<JobRequirements> createState() => _JobRequirementsState();
}

class _JobRequirementsState extends State<JobRequirements>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final JobRequirementsController controller = Get.find();

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Create fade and slide animations for the entire container
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.7), // Start slightly below
      end: Offset.zero, // End at original position
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    // Start the animations
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      width: size.width,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimation.value,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Requirements',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18, // Emphasized heading
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    controller.jobRequirements
                        .map((e) => '● ${e.requirement}')
                        .join('\n \n'),
                    style: textTheme.bodySmall!.copyWith(
                      color: Colors.black.withOpacity(.65),
                      wordSpacing: 5,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
