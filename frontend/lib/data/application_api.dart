import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:khidma/constatnts/constants.dart';

class ApplicationAPI {
  // SUBMIT APPLICATION
  submitApplication(jobID, applicantID, expectedSalary, applicantFullname,
      applicantEmail, applicantPhone, applicantResume) async {
    try {
      Uri endpointUrl = Uri.parse('$BASE_URL/api/application/add');
      var req = await http.post(
        endpointUrl,
        body: json.encode({
          'job_id': jobID,
          'applicant_id': applicantID,
          'expected_salary': expectedSalary,
          'applicant_fullname': applicantFullname,
          'applicant_email': applicantEmail,
          'applicant_phone': applicantPhone,
          'applicant_resume': applicantResume,
        }),
        headers: HEADERS,
      );
      print(req.body);
      if (req.statusCode != 201) {
        throw Exception();
      }
      return req.statusCode;
    } catch (e) {
      rethrow;
    }
  }

  fetchUserApplications(int userid) async {
    try {
      Uri endpointUrl = Uri.parse('$BASE_URL/api/application/fetchbyuser/$userid');
      var req = await http.get(
        endpointUrl,
        headers: HEADERS,
      );
      if (req.statusCode != 200) {
        throw Exception();
      }
      return json.decode(req.body);
    } catch (e) {
      rethrow;
    }
  }
}
