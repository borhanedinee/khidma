import 'package:flutter/material.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class JobDescription extends StatelessWidget {
  const JobDescription({
    super.key, required this.jobModel,
  });

  final JobModel jobModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            // TODO: modify job descriptions in DB to be longer
            jobModel.description,
            style: textTheme.bodySmall!.copyWith(
              color: Colors.grey,
              wordSpacing: 5,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}
