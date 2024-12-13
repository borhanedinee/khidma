import 'package:flutter/material.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class ReviewResume extends StatelessWidget {
  const ReviewResume({
    super.key,
    required this.fileName,
    required this.onReview,
    required this.onReplace,
    required this.onDelete,
  });

  final String fileName;
  final VoidCallback onReview; // Action to review the resume
  final VoidCallback onReplace; // Action to replace the resume
  final VoidCallback onDelete; // Action to delete the resume

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: .4),
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        width: size.width,
        height: 100,
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
              child: const Icon(
                Icons
                    .insert_drive_file_outlined, // Change icon to indicate a file
                size: 30,
                color: Colors.green, // Green to show success
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
                    'Review your resume',
                    style: textTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    fileName, // Display the file name of the uploaded resume
                    style: textTheme.bodySmall!
                        .copyWith(color: Colors.grey, fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, // Handle long file names
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.visibility_outlined, // Eye icon for "review"
                color: Colors.blue,
              ),
              onPressed: onReview, // Review resume action
            ),
            IconButton(
              icon: const Icon(
                Icons.refresh_outlined, // Replace icon for replacing resume
                color: Colors.orange,
              ),
              onPressed: onReplace, // Replace resume action
            ),
            IconButton(
              icon: const Icon(
                Icons.delete, // Replace icon for replacing resume
                color: Colors.red,
              ),
              onPressed: onDelete, // Replace resume action
            ),
          ],
        ),
      ),
    );
  }
}
