import 'package:get/get.dart';
import 'package:khidma/data/jobs_api.dart';
import 'package:khidma/domain/models/job_model.dart';

class JobsOfRecruiterController extends GetxController {
  JobsApi jobsApi = JobsApi();

  //fetching recruiter jobs
  bool isFetchingJobsForRecruiter = false;
  List<JobModel> recruiterJobs = [];
  fetchRecruiterJobs(int recruiterId) async {
    try {
      print(recruiterId);
      // updating ui
      recruiterJobs.clear();
      isFetchingJobsForRecruiter = true;
      update();

      await Future.delayed(
        const Duration(seconds: 3),
      );

      List result = await jobsApi.fetchJobsForRecruiter(recruiterId);
      if (result.isNotEmpty) {
        for (var job in result) {
          recruiterJobs.add(
            JobModel.fromMap(job),
          );
        }
      }
      isFetchingJobsForRecruiter = false;
      update();
    } catch (e) {
      isFetchingJobsForRecruiter = false;
      update();
      Get.showSnackbar(
        GetSnackBar(
          message:
              'Something went wrong fetchiing your jobs, please try again. $e',
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
