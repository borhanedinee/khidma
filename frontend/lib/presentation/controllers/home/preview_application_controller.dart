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
        const Duration(seconds: 1),
      );

      // API CALL
      List result = await applicationAPI.fecthApplicationInfo(applicationID);
      print(List);
      if (result.isNotEmpty) {
        applicationModel = ApplicationModel.fromJson(result.first);
        print(applicationModel == null ? 'null' : applicationModel!.job);
        await Future.delayed(
          const Duration(seconds: 3),
        );
        isFetchingApplicationInfos = false;
        update();
      }
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
