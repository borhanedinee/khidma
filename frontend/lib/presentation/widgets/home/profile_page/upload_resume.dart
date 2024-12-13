import 'package:flutter/material.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class UploadResume extends StatelessWidget {
  final VoidCallback onUploadResume;

  const UploadResume({
    super.key,
    required this.onUploadResume,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onUploadResume,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 22),
        width: size.width,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: .4),
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              height: double.maxFinite,
              width: (size.width - 2 * 24) * .2,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: .4),
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.file_upload_outlined,
                size: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upload your resume',
                    style: textTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Make sure you upload your resume in PDF format.',
                    style: textTheme.bodySmall!
                        .copyWith(color: Colors.grey, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
