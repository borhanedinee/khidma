import 'package:flutter/material.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/services/authentication.dart';
import 'package:khidma/presentation/widgets/onBoarding/job_item.dart';

late TextTheme textTheme;

class OnBoardingOne extends StatelessWidget {
  const OnBoardingOne({super.key});

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          SizedBox(
            height: size.height * .08,
          ),
          JobItem(
            jobModel: JobModel(
              id: 1,
              title: 'UI UX DEsinger',
              type: 'On-Site / Contract',
              category: 'Design',
              location: 'Annaba',
              postedAt: DateTime.now(),
              company: 'EdgeDev + ${AuthenticationService.isUserAuthenticated()}',
              companyLogo: 'assets/logos/startup_one.png',
              salary: 90000,
              description: 'description',
              recruiter: 1,
            ),
            isLeftRadius: false,
          ),
          SizedBox(
            height: size.height * .02,
          ),
          JobItem(
            jobModel: JobModel(
              id: 1,
              title: 'Mobile Developer',
              type: 'Remote',
              category: 'Developer',
              location: 'Algiers',
              postedAt: DateTime.now(),
              company: 'TechAdvance',
              companyLogo: 'assets/logos/recruitingLOGO.png',
              salary: 79000,
              description: 'description',
              recruiter: 1,
            ),
            isLeftRadius: true,
          ),
          SizedBox(
            height: size.height * .05,
          ),
          SizedBox(
            width: size.width - 30,
            child: Column(
              children: [
                Text(
                  'Find Your Dream Job',
                  style: textTheme.titleLarge!.copyWith(
                    color: Colors.yellow
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'We help you find your dream job according to your skillset, location and preference to build your career',
                  style: textTheme.bodySmall,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
