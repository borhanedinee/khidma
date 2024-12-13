import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/home/home_controller.dart';
import 'package:khidma/presentation/services/authentication.dart';
import 'package:khidma/presentation/services/get_saved_user.dart';
import 'package:khidma/presentation/shimmers/home_shimmers/popular_job_shimmer.dart';
import 'package:khidma/presentation/widgets/home/home_page/home_app_bar.dart';
import 'package:khidma/presentation/widgets/home/home_page/home_popular_jobs.dart';
import 'package:khidma/presentation/widgets/home/home_page/popular_job.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeController.fetchJobs();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => CustomScrollView(
        slivers: [
          HomeAppBar(
            currentUser: AuthenticationService.isUserAuthenticated()? getSavedUser().fullname : null,
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 30, left: 10),
              child: MyHomeHeader(
                headerLabel: 'Categories',
              ),
            ),
          ),
          // Categorie
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                height: 100,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    controller.categorie.length,
                    (index) {
                      String category =
                          controller.categorie.keys.elementAt(index);
                      IconData icon = controller.categorie[category]!;
                      return Container(
                        height: 130,
                        width: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: .4),
                          color: controller.selectedCategorie == category
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        margin: EdgeInsets.only(
                          left: index == 0 ? 20 : 10,
                          right: index == controller.categorie.length - 1
                              ? 20
                              : 10,
                        ),
                        child: InkWell(
                          onTap: () {
                            controller.updateSelectedCategorie(category);
                            controller.fetchSelectedCategoryJobs();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                icon,
                                size: 30,
                                color: controller.selectedCategorie == category
                                    ? Colors.yellow
                                    : Theme.of(context).primaryColor,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                category,
                                style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      controller.selectedCategorie == category
                                          ? Colors.yellow
                                          : Theme.of(context).primaryColor,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          if (controller.selectedCategorie != '')
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: MyHomeHeader(
                  showIcon: true,
                  headerLabel: 'Filtered Jobs',
                ),
              ),
            ),
          if (controller.isFetchingFilteredJobs) _loadingFilteredJobs(),
          // headline
          if (controller.filteredJobs.isNotEmpty) _displayFiltredProducts(),

          if (!controller.isFetchingFilteredJobs &&
              controller.filteredJobs.isEmpty &&
              controller.selectedCategorie == '')
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: MyHomeHeader(
                  headerLabel: 'Popular Jobs',
                  showIcon: true,
                ),
              ),
            ),
          if (!controller.isFetchingFilteredJobs &&
              controller.filteredJobs.isEmpty &&
              controller.selectedCategorie == '')
            SliverToBoxAdapter(
              child: SizedBox(
                child: controller.isFetchingJobsLoading
                    ? const PopularJobsShimmer()
                    : const HomePopularJobs(),
              ),
            ),

          if (!controller.isFetchingFilteredJobs &&
              controller.filteredJobs.isEmpty &&
              controller.selectedCategorie == '')
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: MyHomeHeader(
                  showIcon: true,
                  headerLabel: 'Recently Posted',
                ),
              ),
            ),

          if (!controller.isFetchingFilteredJobs &&
              controller.filteredJobs.isEmpty &&
              controller.selectedCategorie == '')
            controller.isFetchingJobsLoading
                ? SliverList(
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
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        JobModel jobModel = controller.recentJobs[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
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

  SliverToBoxAdapter _displayFiltredProducts() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(
          top: 10,
        ),
        height: (size.height - 20) * .3,
        child: GetBuilder<HomeController>(
          builder: (controller) => ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              JobModel job = controller.filteredJobs[index];
              return Padding(
                padding: const EdgeInsets.only(left: 15),
                child: PopularJob(
                  jobModel: job,
                  isLeftRadius: index.isEven,
                ),
              );
            },
            itemCount: controller.filteredJobs.length,
          ),
        ),
      ),
    );
  }

  SliverList _loadingFilteredJobs() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade200,
              highlightColor: Colors.grey.shade100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  width: (size.width - 24) - 50,
                  height: 220,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          );
        },
        childCount: 1, // Number of shimmer placeholders
      ),
    );
  }
}
