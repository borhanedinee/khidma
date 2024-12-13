import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:khidma/data/skills_api.dart';
import 'package:khidma/domain/models/skill_model.dart';
import 'package:khidma/presentation/services/get_saved_user.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class SkillsController extends GetxController {
  final SkillsAPI _skillsAPI = SkillsAPI();

  //fetch user skills
  bool isFetchingUsrSkills = false;
  List<SkillModel> userSkills = [];
  fetchUserSkills(int userid) async {
    try {
      // update ui
      userSkills.clear();
      isFetchingUsrSkills = true;
      update();

      await Future.delayed(
        const Duration(seconds: 3),
      );

      List results = await _skillsAPI.fetchUserSkills(userid);
      if (results.isNotEmpty) {
        for (var skill in results) {
          userSkills.add(SkillModel.fromJson(skill));
        }
      }
      isFetchingUsrSkills = false;
      update();
    } catch (e) {
      isFetchingUsrSkills = false;
      update();
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Something went wrong fetching user skills',
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  // add skill
  addSkill(String skillName) async {
    try {
      // optimistic ui
      userSkills.add(
        SkillModel(id: 0, skill: skillName, userId: getSavedUser().id),
      );
      update();

      await Future.delayed(
        Duration(seconds: 3),
      );

      final result = await _skillsAPI.addSkill(getSavedUser().id, skillName);

      if (result != true) {
        throw Exception();
      }
    } catch (e) {
      userSkills.removeWhere((element) => element.skill == skillName);
      update();
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Error adding skill',
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  // DOWNLOAD RESUME
  Future<void> openResume(String url, String fileName, context) async {
    try {
      print(url);
      String filePath;

      // DOWNLOAD AND OPEN
      final directory = await getDownloadsDirectory();
      filePath = '${directory!.path}/$fileName';

      // Use Dio to download the file
      final dio = Dio();
      await dio.download(
        url,
        filePath,
      );
      _openFile(filePath);
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          message: 'Error downloading file: $e',
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _openFile(String filePath) async {
    final result = await OpenFile.open(filePath);
    if (result.type == ResultType.error) {
      Get.showSnackbar(
        GetSnackBar(
          message: 'Error opening file: ${result.message}',
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
