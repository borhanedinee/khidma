import 'package:get/get.dart';
import 'package:khidma/data/jobs_api.dart';
import 'package:khidma/domain/models/job_model.dart';

class HomeController extends GetxController {
  JobsApi jobsApi = JobsApi();

  bool isFetchingJobsLoading = false;
  List<JobModel> popularJobs = [];
  List<JobModel> recentJobs = [];
  List<JobModel> jobs = [];
  fetchJobs() async {
    try {
      isFetchingJobsLoading = true;
      update();
      await Future.delayed(
        Duration(seconds: 3),
      );
      List<dynamic> results = await jobsApi.fetchJobs();
      
      for (var job in results) {
        print(job);
        jobs.add(JobModel.fromMap(job));
        print(jobs);
      }

      recentJobs = jobs.reversed.take(6).toList();
      popularJobs = jobs.take(6).toList();

      
    
      isFetchingJobsLoading = false;
      update();
    } catch (e) {
      print(e);
      isFetchingJobsLoading = false;
      update();
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Something went wrong, please try again.',
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
