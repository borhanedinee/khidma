import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/auth/login_page.dart';
import 'package:khidma/presentation/widgets/home/popular_job.dart';
import 'package:khidma/presentation/widgets/home/my_home_header.dart';
import 'package:khidma/presentation/widgets/home/recent_job.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250.0,
          floating: false,
          pinned: true,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(.3),
          flexibleSpace: FlexibleSpaceBar(
            background: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Search \nFind & Apply',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 36,
                        ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.to(
                  const LoginPage(),
                );
              },
              child: const Text(
                'Join us',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: Container(
              color: Theme.of(context).primaryColor.withOpacity(.01),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Search...",
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: const Icon(Icons.settings)),
                ),
              ),
            ),
          ),
        ),
        // headline
        const SliverToBoxAdapter(
          child: MyHomeHeader(
            headerLabel: 'Popular Jobs',
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: (size.height - 20) * .3,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => PopularJob(
                jobModel: JobModel(
                  companyName: 'Versily',
                  companyLogo: 'assets/logos/recruitingLOGO.png',
                  jobTitle: 'Software Engineer - Full-Stack',
                  jobType: 'Remote',
                  jobSalary: '\$70k/Yearly',
                ),
                isLeftRadius: index.isEven,
              ),
              itemCount: 6,
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: MyHomeHeader(headerLabel: 'Recently Posted'),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => const RecentJob(),
          ),
        ),
      ],
    );
  }
}
