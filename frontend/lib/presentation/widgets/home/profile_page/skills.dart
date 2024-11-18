import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/home/profile_controller.dart';
import 'package:khidma/presentation/widgets/home/my_form_field.dart';

class Skills extends StatelessWidget {
  Skills({
    super.key,
  });

  final TextEditingController fieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
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
            controller.skills.isEmpty
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
                      controller.skills.length,
                      (index) {
                        List skillReversed = controller.skills.reversed.toList();
                        String skill = skillReversed[index];
                        return Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(skill),
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
      ProfileController controller, TextEditingController fieldController) {
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
      ),
    );
  }
}
