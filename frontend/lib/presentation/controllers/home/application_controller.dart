import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/constants.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/services/get_saved_user.dart';
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ApplicationController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // UPLOAD RESUME
  Future<void> pickSaveAndUploadFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'], // Restrict to PDF files
      );

      if (result != null) {
        String filePath = result.files.single.path!;
        File file = File(filePath); // Get the file

        // NOW UPLOADING FILE TO BACKEND
        // Prepare the file for upload
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(
            '$BASE_URL/api/uploadresume',
          ),
        );
        request.files
            .add(await http.MultipartFile.fromPath('resume', file.path));
        request.fields['userid'] = getSavedUser().id.toString();

        // Send the request
        var response = await request.send();

        // Handle the response
        if (response.statusCode == 200) {
          print("File uploaded successfully");
          // Save the file path in SharedPreferences

          await prefs.setString('userlocalresume', filePath);

          // means it did got changed
          await prefs.setBool('userremoteresumeISNOTchanged', false);

          // Update the UI with removing the upload resume card
          update();

          Get.showSnackbar(
            const GetSnackBar(
              message: 'File uploaded and saved successfully!',
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          print("File upload failed with status: ${response.statusCode}");
          Get.showSnackbar(
            GetSnackBar(
              message:
                  'File upload failed with status: ${response.stream.toStringStream()}',
              duration: Duration(seconds: 2),
            ),
          );
        }
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
    String? savedFilePath = await prefs.getString('userlocalresume');
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

  // DOWNLOAD RESUME
  Future<void> downloadPdf(String url, String fileName , context) async {
    try {
      // Get the application documents directory
      // final directory = await getApplicationDocumentsDirectory();
      final directory = await getDownloadsDirectory();
      final filePath = '${directory!.path}/$fileName';

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

  void _showOpenFileDialog(String filePath , context) {
    showBottomSheet(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Open File'),
          content: const Text(
              'The file has been downloaded. Do you want to open it?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close the dialog
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _openFile(filePath); // Open the file
              },
              child: const Text('Open'),
            ),
          ],
        );
      },
    );
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
