import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:khidma/constatnts/constants.dart';

class JobsApi {

  // fetch home jobs
  fetchJobs() async {
    try {
      var req = await http.get(
        Uri.parse('$BASE_URL/api/jobs/fetch'),
      );
      if (req.statusCode == 200) {
        return json.decode(req.body);
      } else {
        throw Exception('Failed to fetch jobs');
      }
    } catch (e) {
      rethrow;
    }
  }

  // fetch jobs for recruiter
  fetchJobsForRecruiter(int recruiterId ) async {
     try {
      var req = await http.get(
        Uri.parse('$BASE_URL/api/jobs/fetchjobsforrecruiter/$recruiterId'),
      );
      if (req.statusCode == 200) {
        return json.decode(req.body);
      } else {
        throw Exception('Failed to fetch jobs');
      }
    } catch (e) {
      rethrow;
    }
  }

  // fetch jobsby category
  fetchJobsByCategory(String category)async{
    try {
      var req = await http.get(
        Uri.parse('$BASE_URL/api/jobs/fetchjobscat/$category'),
      );
      if (req.statusCode == 200) {
        return json.decode(req.body);
      } else {
        throw Exception('Failed to fetch jobs');
      }
    } catch (e) {
      rethrow;
    }
  }
}
