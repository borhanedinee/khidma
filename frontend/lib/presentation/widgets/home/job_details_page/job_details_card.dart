
import 'package:flutter/material.dart';
import 'package:khidma/constants.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class JobDetailsCard extends StatelessWidget {
  const JobDetailsCard({
    super.key,
    required this.jobModel,
  });

  final JobModel jobModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 40,
            bottom: -70,
            child: Opacity(
                opacity: .2,
                child: Image.asset(
                  'assets/images/photo.png',
                  height: 230,
                )),
          ),
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: 50,
                child: Image.network(
                  '$IMAGE_URL/${jobModel.companyLogo}',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                jobModel.title,
                style: textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                // TODO: implement job location in DB
                'Algiers ( Remote )',
                style: textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.grey.shade600),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12 , vertical:3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    child: Text(jobModel.type),
                  ),
                  Text(
                    '${jobModel.salary.toInt()} DA',
                    style: textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
