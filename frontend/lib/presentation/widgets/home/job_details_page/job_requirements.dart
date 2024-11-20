
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/domain/models/job_requirement_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/home/job_requirements_controller.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class JobRequirements extends StatelessWidget {
  JobRequirements({
    super.key,
  });

  JobRequirementsController controller =  Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.symmetric(horizontal: 24),
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Requirements',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          ...List.generate(
              controller.jobRequirements.length,
              (index) {
            JobRequirementModel jobRequirementModel =
                controller.jobRequirements[index];
            return Text(
              '● ${jobRequirementModel.requirement}',
              style: textTheme.bodySmall!
                  .copyWith(color: Colors.grey),
            );
          }),
        ],
      ),
    );
  }
}