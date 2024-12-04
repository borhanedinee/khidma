import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/constatnts/constants.dart';
import 'package:khidma/data/application_api.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/services/get_saved_user.dart';
import 'package:khidma/presentation/widgets/home/submitt_application_page/submission_failure/submission_failure_page.dart';
import 'package:khidma/presentation/widgets/home/submitt_application_page/submission_success/subbmission_success_page.dart';
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class SubmittingApplicationController extends GetxController {
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

  // SUBMIT APPLICATION
  bool isSubmittingApplicationLoading = false;
  submitApplication(jobID, applicantID, expectedSalary, applicantFullname,
      applicantEmail, applicantPhone, applicantResume) async {
    // TODO: handle applicantResume when the user firstly upload his resume
    // the resume should be the same as the stored on the server
    // so that it is accessible
    try {
      isSubmittingApplicationLoading = true;
      update();
      await Future.delayed(
        const Duration(seconds: 4),
      );

      // SEND REQUEST to
      var result = await applicationAPI.submitApplication(
        jobID,
        applicantID,
        expectedSalary,
        applicantFullname,
        applicantEmail,
        applicantPhone,
        applicantResume,
      );
      if (result != 201) {
        throw Exception();
      }
      // STATUS CODE IS 201 -- success
      isSubmittingApplicationLoading = false;
      update();

      // NAVIGATING TO SUBMISSION SUCCESS PAGE
      Get.to(SubmissionSuccessScreen());
    } catch (e) {
      // STATUS CODE IS NOT 201 -- failure
      isSubmittingApplicationLoading = false;
      update();
      // NAVIGATING TO SUBMISSION FAILURE PAGE
      Get.to(const SubmissionFailureScreen());
    }
  }

  // DELETE RESUME
  bool isResumeDeleting = false;
  deleteResume(int userID) async {
    try {
      isResumeDeleting = true;
      update();
      await Future.delayed(
        const Duration(seconds: 3),
      );

      var req = await http.delete(
        Uri.parse('$BASE_URL/api/deleteresume/$userID'),
      );
      if (req.statusCode != 200) {
        throw Exception();
      }

      prefs.setBool('dbgotresume', false);
      prefs.remove('userlocalresume');

      // deleted successfully

      Get.showSnackbar(
        const GetSnackBar(
          message: 'Resume was successfully deleted',
          duration: Duration(seconds: 3),
        ),
      );
      isResumeSelected = false;
      isResumeDeleting = false;
      update();
    } catch (e) {
      isResumeDeleting = false;
      update();
      // deleting failed
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Something went wrong deleting resume',
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  // UPLOAD RESUME
  bool isUploadingFileLoading = false;
  Future<void> pickSaveAndUploadFile() async {
    try {
      // PICK FILE
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'], // Restrict to PDF files
      );

      if (result != null) {
        try {
          String pickedFilePath = result.files.single.path!;
          File pickedFile = File(pickedFilePath); // Get the file

          // UPDATE UI
          isUploadingFileLoading = true;
          update();

          // sending file to backend and saving it in prefs
          await uploadFileToBackend(pickedFile);

          // SUCCESS

          // SAVE FILE
          await prefs.setBool('dbgotresume', true);
          await prefs.setString('userlocalresume', pickedFilePath);
          await prefs.setBool('userremoteresumeISNOTchanged', false);

          // UPDATE UI
          isResumeSelected = true;
          isUploadingFileLoading = false;
          update();
        } catch (e) {
          // UPDATE UI
          isUploadingFileLoading = false;

          update();
          // CATCHING EXCEPTION WHILE UPLOADING FILE
          Get.showSnackbar(
            const GetSnackBar(
              message: 'File upload failed',
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
      // CATCHING EXCEPTION WHILE PICKING FILE
      Get.showSnackbar(
        GetSnackBar(
          message: 'Error picking file $e!',
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> uploadFileToBackend(File pickedFile) async {
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
    request.fields['userid'] = getSavedUser().id.toString();

    var response = await request.send();

    // Handle the response
    if (response.statusCode == 200) {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'File uploaded and saved successfully!',
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      throw Exception();
    }
  }

  // OPEN RESUME
  Future<void> openSavedFile() async {
    String? savedFilePath = prefs.getString('userlocalresume');
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
  Future<void> downloadAndOpenResume(
      String url, String fileName, context) async {
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
}
