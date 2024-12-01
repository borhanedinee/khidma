
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/presentation/pages/home_pages/preview_application_page.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class EditApplicationAppBar extends StatelessWidget {
  final int applicantID;

  const EditApplicationAppBar({
    super.key, required this.applicantID,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  Get.off(()=>
                    ApplicationPreviewScreen(applicantID: applicantID)
                  );
                },
                icon: const Icon(
                  Icons.navigate_before_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 22),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Edit Application',
                style: textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
