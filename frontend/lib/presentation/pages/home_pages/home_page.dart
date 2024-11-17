import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/constants.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/drawer_controller.dart';
import 'package:khidma/presentation/pages/auth/login_page.dart';
import 'package:khidma/presentation/pages/home_pages/profile_page.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';
import 'package:khidma/presentation/widgets/home/popular_job.dart';
import 'package:khidma/presentation/widgets/home/my_home_header.dart';
import 'package:khidma/presentation/widgets/home/recent_job.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
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
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Search \nFind & Apply',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                ),
              ],
            ),
          ),
          title: prefs.getString('userfullname') == null? null : Text('Hi, ${(prefs.getString('userfullname')!.split(' ').last)}'),
          actions: [
            prefs.getString('userfullname') == null
                ? TextButton(
                    onPressed: () {
                      Get.to(
                        LoginPage(),
                      );
                    },
                    child: const Text(
                      'Join us',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  )
                : 
                GetBuilder<MyDrawerController>(
                  builder: (controller) => InkWell(
                    onTap: () {
                      controller.changeCurrentPage(const ProfilePage());
                      controller.changeSelectedDrawerItem('P R O F I L E');
                    },
                    child: CircleAvatar(
                      radius: 15,
                        backgroundImage:
                            NetworkImage('$IMAGE_URL/${prefs.getString('useravatar')}'),
                      ),
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle:
                        textTheme.bodySmall!.copyWith(color: Colors.grey),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: const Icon(Icons.settings),
                  ),
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
            childCount: 10
          ),
        ),
      ],
    );
  }
}
