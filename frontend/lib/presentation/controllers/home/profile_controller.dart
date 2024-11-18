import 'package:get/get.dart';

class ProfileController extends GetxController {
  List<String> skills = [];
  addSkill(String skill) {
    skills.add(skill);
    update();
  }
}
