import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/presentation/controllers/home/home_controller.dart';
import 'package:khidma/presentation/shimmers/home_shimmers/popular_job_shimmer.dart';
import 'package:khidma/presentation/widgets/home/home_page/home_app_bar.dart';
import 'package:khidma/presentation/widgets/home/home_page/home_popular_jobs.dart';
import 'package:khidma/presentation/widgets/home/my_home_header.dart';
import 'package:khidma/presentation/widgets/home/home_page/recent_job.dart';
import 'package:shimmer/shimmer.dart';

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
                  ? const PopularJobsShimmer()
                  : const HomePopularJobs(),
            ),
          ),

          const SliverToBoxAdapter(
            child: MyHomeHeader(headerLabel: 'Recently Posted'),
          ),

          controller.isFetchingJobsLoading?
           SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade200,
                  highlightColor: Colors.grey.shade100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: double.infinity,
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                );
              },
              childCount: 6, // Number of shimmer placeholders
            ),
          ):
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                JobModel jobModel = controller.recentJobs[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: RecentJob(
                    jobModel: jobModel,
                  ),
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
