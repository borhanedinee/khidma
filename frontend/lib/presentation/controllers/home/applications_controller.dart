import 'package:get/get.dart';
import 'package:khidma/data/application_api.dart';
import 'package:khidma/domain/models/application_model.dart';

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
}
