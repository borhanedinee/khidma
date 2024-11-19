import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/presentation/controllers/home/home_controller.dart';
import 'package:khidma/presentation/widgets/home/home_page/home_app_bar.dart';
import 'package:khidma/presentation/widgets/home/home_page/home_popular_jobs.dart';
import 'package:khidma/presentation/widgets/home/my_home_header.dart';
import 'package:khidma/presentation/widgets/home/recent_job.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = Get.find();
  @override
  void initState() {
    homeController.fetchJobs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => CustomScrollView(
        slivers: [
          const HomeAppBar(),
          // headline
          const SliverToBoxAdapter(
            child: MyHomeHeader(
              headerLabel: 'Popular Jobs',
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              child: controller.isFetchingJobsLoading
                  ? CircularProgressIndicator()
                  : HomePopularJobs(),
            ),
          ),

          const SliverToBoxAdapter(
            child: MyHomeHeader(headerLabel: 'Recently Posted'),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                JobModel jobModel = controller.recentJobs[index];
                return RecentJob(
                  jobModel: jobModel,
                );
              },
              childCount: controller.recentJobs.length,
            ),
          ),
        ],
      ),
    );
  }
}
