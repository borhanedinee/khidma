import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/constatnts/constants.dart';
import 'package:khidma/data/application_api.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/services/get_saved_user.dart';
import 'package:khidma/presentation/widgets/home/edit_application_page/editting_failure/editting_failure_page.dart';
import 'package:khidma/presentation/widgets/home/edit_application_page/editting_success/editting_success_page.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;

class EditApplicationController extends GetxController {
  ApplicationAPI applicationAPI = ApplicationAPI();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // GET APPLICANT RESUME
  bool isResumeSelected = true;
  String? get applicantResume {
    return prefs.getBool('dbgotresume')! &&
            prefs.getBool('userremoteresumeISNOTchanged')!
        ? getSavedUser().resume
        : prefs.getString('userlocalresume');
  }

  // FORM CONTROLLERS

  TextEditingController emailController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController expectedSalaryController = TextEditingController();

  // EDIT APPLICATION
  bool isEditingApplicationLoading = false;
  editApplication(fullname, email, phone, expectedSalary, applicationID) async {
    try {
      isEditingApplicationLoading = true;
      update();
      await Future.delayed(
        const Duration(seconds: 3),
      );
      int result = await applicationAPI.editApplication(
          fullname, email, phone, expectedSalary, applicationID);
      if (result != 200) {
        throw Exception();
      }
      // STATUS CODE IS 200 -- success
      isEditingApplicationLoading = false;
      update();

      // NAVIGATING TO SUBMISSION SUCCESS PAGE
      Get.to(EdittingSuccessScreen());
    } catch (e) {
      // STATUS CODE IS NOT 201 -- failure
      isEditingApplicationLoading = false;
      update();
      // NAVIGATING TO SUBMISSION FAILURE PAGE
      Get.to(const EdittingFailureScreen());
    }
  }

  // UPLOAD RESUME
  bool isEditingResumeLoading = false;
  Future<void> pickSaveAndUploadFile(String applicationID) async {
    try {
      // PICK NEW RESUME
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'], // Restrict to PDF files
      );

      if (result != null) {
        try {
          String pickedFilePath = result.files.single.path!;
          File pickedFile = File(pickedFilePath); // Get the file

          // UPDATE UI
          isEditingResumeLoading = true;
          update();

          // sending file to backend and saving it in prefs
          await uploadFileToBackend(pickedFile, applicationID);

          // SUCCESS
          prefs.setString('edittedresume', pickedFilePath);
          isSaveButtonClickable = true;

          // UPDATE UI
          isEditingResumeLoading = false;
          update();
        } catch (e) {
          // UPDATE UI
          isEditingResumeLoading = false;

          update();
          // CATCHING EXCEPTION WHILE UPLOADING FILE
          Get.showSnackbar(
            const GetSnackBar(
              message: 'Resume Editting failed',
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        Get.showSnackbar(
          const GetSnackBar(
            message: 'No Resume selected!',
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // CATCHING EXCEPTION WHILE PICKING FILE
      Get.showSnackbar(
        GetSnackBar(
          message: 'Error picking resume $e!',
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> uploadFileToBackend(
      File pickedFile, String applicationID) async {
    // NOW UPLOADING FILE TO BACKEND
    await Future.delayed(
      const Duration(seconds: 4),
    );
    // Prepare the file for upload
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        '$BASE_URL/api/uploadresume',
      ),
    );
    request.files
        .add(await http.MultipartFile.fromPath('resume', pickedFile.path));
    request.fields['applicationid'] = applicationID;

    var response = await request.send();

    // Handle the response
    if (response.statusCode == 200) {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'File Edited successfully!',
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      throw Exception();
    }
  }

  // OPEN RESUME
  Future<void> openSavedFile() async {
    String? savedFilePath = prefs.getString('edittedresume');
    if (savedFilePath != null && savedFilePath.isNotEmpty) {
      final result = await OpenFile.open(savedFilePath);

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
        const GetSnackBar(
          message: 'No File path saved in Shared Preferences',
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // DOWNLOAD RESUME
  Future<void> openResume(String url, String fileName, context) async {
    try {
      String filePath;
      if (prefs.getString('edittedresume') == null) {
        // RESUME IS NOT CHANGED YET

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
      } else {
        // RESUME IS CHANGED SO OPEN FROM SAVED FILE
        openSavedFile();
      }
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          message: 'Error downloading file: $e',
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _showOpenFileDialog(String filePath, context) {
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

  bool isSaveButtonClickable = false;
  updateIsSaveButtonClickable(
      defaultFullname, defaultEmail, defaultPhone, defaultSalary) {
    if (fullnameController.text == defaultFullname &&
        emailController.text == defaultEmail &&
        phoneController.text == defaultPhone &&
        expectedSalaryController.text == defaultSalary &&
        prefs.getString('edittedresume') == null) {
      isSaveButtonClickable = false;
    } else {
      isSaveButtonClickable = true;
    }
    update();
  }
}
