import 'package:get/get.dart';
import 'package:khidma/data/application_api.dart';
import 'package:khidma/domain/models/application_model.dart';

class PreviewApplicationController extends GetxController {
  ApplicationAPI applicationAPI = ApplicationAPI();

  // FETCHING APPLICATION INFOS
  bool isFetchingApplicationInfos = false;
  ApplicationModel? applicationModel;
  fetchApplicationInfos(applicationID) async {
    try {
      isFetchingApplicationInfos = true;
      update();
      await Future.delayed(
        const Duration(seconds: 3),
      );

      // API CALL
      List result = await applicationAPI.fecthApplicationInfo(applicationID);
      print(result.first);
      if (result.isEmpty) {
        Get.showSnackbar(
          const GetSnackBar(
            message: 'Failed to fetch application info',
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        applicationModel = ApplicationModel.fromJson(result.first);
      }

      isFetchingApplicationInfos = false;
      update();
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          message: 'Failed to fetch application info $e',
          duration: Duration(seconds: 3),
        ),
      );
      isFetchingApplicationInfos = false;
      update();
    }
  }
}
