import 'package:get/get.dart';
import 'package:khidma/data/job_requirements_api.dart';
import 'package:khidma/domain/models/job_requirement_model.dart';

class JobRequirementsController extends GetxController {
  JobRequirementsApi jobRequirementsApi = JobRequirementsApi();

  bool isFetchingJobRequirementsLoading = false;
  List<JobRequirementModel> jobRequirements = [];
  fetchJobRequirements(jobID) async {
    try {
      isFetchingJobRequirementsLoading = true;
      update();
      await Future.delayed(
        Duration(seconds: 1),
      );
      List results = await jobRequirementsApi.fetchJobRequirements(jobID);
      print(results);
      if (results.isNotEmpty) {
        for (var jobReq in results) {
          jobRequirements.add(JobRequirementModel.fromJson(jobReq));
        }
      }

      isFetchingJobRequirementsLoading = false;
      update();
    } catch (e) {
      isFetchingJobRequirementsLoading = false;
      update();
      print(e);
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Could not fetch job details, please try again',
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

}
