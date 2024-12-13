import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class EditResume extends StatelessWidget {
  const EditResume({
    super.key,
    required this.fileName,
    required this.onReview,
    required this.onReplace,
  });

  final String fileName;
  final VoidCallback onReview; // Action to review the resume
  final VoidCallback onReplace; // Action to replace the resume

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: size.width,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: .4),
        color: Colors.white,
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
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Ionicons.document_text, // Change icon to indicate a file
              size: 30,
              color: Colors.red, // Green to show success
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
                  'Edit your resume',
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
        ],
      ),
    );
  }
}
