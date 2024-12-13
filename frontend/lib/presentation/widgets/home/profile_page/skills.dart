import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/home/profile_controller.dart';
import 'package:khidma/presentation/controllers/home/skills_controller.dart';
import 'package:khidma/presentation/services/get_saved_user.dart';
import 'package:khidma/presentation/widgets/home/my_form_field.dart';

class Skills extends StatefulWidget {
  Skills({
    super.key,
  });

  @override
  State<Skills> createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  final TextEditingController fieldController = TextEditingController();
  SkillsController skillsController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      skillsController.fetchUserSkills(getSavedUser().id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SkillsController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Skills'),
                  IconButton(
                    onPressed: () {
                      showAddSkillModal(
                        context,
                        controller,
                        fieldController,
                      );
                    },
                    icon: const Icon(
                      Icons.add_circle_outline,
                    ),
                  ),
                ],
              ),
            ),
            controller.isFetchingUsrSkills
                ? const Text(
                    'fetching skills...',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                : controller.userSkills.isEmpty
                    ? const Text(
                        'No added skills.',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    : Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(
                          controller.userSkills.length,
                          (index) {
                            // List skillReversed =
                            //     controller.userSkills.reversed.toList();
                            final skill = controller.userSkills[index];
                            return Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(skill.skill),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showAddSkillModal(BuildContext context,
      SkillsController controller, TextEditingController fieldController) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.red),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (fieldController.text.trim() == '') {
                Get.showSnackbar(
                  const GetSnackBar(
                    message: 'Skill must not be empty.',
                    duration: Duration(seconds: 2),
                  ),
                );
              } else {
                controller.addSkill(fieldController.text.trim());
                Get.back();
                fieldController.clear();
              }
            },
            child: const Text('Add'),
          ),
        ],
        content: SizedBox(
          width: size.width,
          child: MyFormField(
            fieldController: fieldController,
            hintText: 'Enter skills',
            isPassword: false,
          ),
        ),
        title: const Text(
          'By adding your skills, you help us suggest suitable jobs for you.',
          style: TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
