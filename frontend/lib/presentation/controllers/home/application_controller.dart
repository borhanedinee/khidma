import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/main.dart';
import 'package:open_file/open_file.dart';

class ApplicationController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // UPLOAD RESUME
  Future<void> pickAndSaveFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'], // Restrict to PDF files
      );

      if (result != null) {
        String filePath = result.files.single.path!;

        // Save the file path in SharedPreferences
        await prefs.setString('userresume', filePath);

        // Update the UI with removing the upload resume card
        update();

        Get.showSnackbar(
          const GetSnackBar(
            message: 'File saved successfully!',
            duration: Duration(seconds: 2),
          ),
        );
      } else {
         Get.showSnackbar(
          const GetSnackBar(
            message: 'No file selected!',
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
       Get.showSnackbar(
          GetSnackBar(
            message: 'Error picking file $e!',
            duration: const Duration(seconds: 2),
          ),
        );
    }
  }

  // OPEN RESUME
  Future<void> openSavedFile() async {
    String? savedFilePath = await prefs.getString('userresume');
    if (savedFilePath != null && savedFilePath!.isNotEmpty) {
      final result = await OpenFile.open(savedFilePath!);

      if (result.type == ResultType.error) {
        Get.showSnackbar(
          GetSnackBar(
            message: 'Error opening file: ${result.message}',
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } else {
      Get.showSnackbar(
          GetSnackBar(
            message: 'No File path saved in Shared Preferences',
            duration: const Duration(seconds: 2),
          ),
        );
    }
  }
}
