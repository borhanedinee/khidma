import 'package:flutter/material.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/main.dart';
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
              companyName: 'Versily',
              companyLogo: 'assets/logos/recruitingLOGO.png',
              jobTitle: 'Software Engineer - Full-Stack',
              jobType: 'Remote',
              jobSalary: '\$70k/Yearly',
            ),
            isLeftRadius: false,
          ),
          
          SizedBox(
            height: size.height * .02,
          ),
          JobItem(
            jobModel: JobModel(
              companyName: 'InnoTech',
              companyLogo: 'assets/logos/startup_one.png',
              jobTitle: 'Flutter Developer',
              jobType: 'Remote',
              jobSalary: '\$70k/Yearly',
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
                  style: textTheme.titleMedium,
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
