import 'package:flutter/material.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class JobDescription extends StatefulWidget {
  const JobDescription({
    super.key,
    required this.jobModel,
  });

  final JobModel jobModel;

  @override
  _JobDescriptionState createState() => _JobDescriptionState();
}

class _JobDescriptionState extends State<JobDescription>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Fade animation
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    // Slide animation (from bottom to its position)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.7), // Start slightly below
      end: Offset.zero, // End at the original position
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
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          width: size.width,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Description',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18, // Slightly larger for emphasis
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                // TODO: modify job descriptions in DB to be longer
                widget.jobModel.description,
                style: textTheme.bodySmall!.copyWith(
                  color: Colors.grey,
                  wordSpacing: 5,
                  letterSpacing: 1.5, // Balanced letter spacing
                  height: 1.5, // Line height for better readability
                ),
              ),
            ],
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
