
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/home/home_controller.dart';
import 'package:khidma/presentation/widgets/home/home_page/popular_job.dart';

class HomePopularJobs extends StatelessWidget {
  const HomePopularJobs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (size.height - 20) * .3,
      child: GetBuilder<HomeController>(
        builder: (controller) => ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            JobModel job = controller.popularJobs[index];
            return Padding(
              padding: const EdgeInsets.only(left: 15),
              child: PopularJob(
              jobModel: job,
              isLeftRadius: index.isEven,
                        ),
            );
          },
          itemCount: controller.popularJobs.length,
        ),
      ),
    );
  }
}
