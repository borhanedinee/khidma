import 'package:get/get.dart';
import 'package:khidma/data/application_api.dart';
import 'package:khidma/domain/models/application_model.dart';
import 'package:khidma/domain/models/job_applicantion_model.dart';

class ApplicationsController extends GetxController {
  final ApplicationAPI _applicationAPI = ApplicationAPI();
  // FECTHING APPLICATIONS
  bool isFetchingApplicationsLoading = false;
  List<ApplicationModel> applications = [];
  fetchUserApplications(int userid) async {
    try {
      applications.clear();
      isFetchingApplicationsLoading = true;
      update();
      await Future.delayed(
        const Duration(seconds: 3),
      );

      // request
      List results = await _applicationAPI.fetchUserApplications(userid);
      if (results.isEmpty) {
        isFetchingApplicationsLoading = false;
        update();
        return;
      }
      for (var application in results) {
        print(application);
        applications.add(ApplicationModel.fromJson(application));
      }

      isFetchingApplicationsLoading = false;
      update();
    } catch (e) {
      isFetchingApplicationsLoading = false;
      update();
      Get.showSnackbar(
        GetSnackBar(
          message: 'Something went wrong fetching applications $e',
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  // fetch applicants for specific job
  bool isFetchingJobApplicantions = false;
  List<JobApplicationModel> jobApplications = [];
  fetchJobApplicants(int jobid) async {
    try {
      // update ui
      isFetchingJobApplicantions = true;
      update();
      await Future.delayed(
        const Duration(seconds: 3),
      );

      List results = await _applicationAPI.fetchJobApplicants(jobid);
      if (results.isNotEmpty) {
        for (var application in results) {
          jobApplications.add(
            JobApplicationModel.fromJson(application),
          );
        }
      }

      isFetchingJobApplicantions = false;
      update();
    } catch (e) {
      isFetchingJobApplicantions = false;
      update();
      Get.showSnackbar(
        GetSnackBar(
          message: 'Something went wrong fetching job applications $e',
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
