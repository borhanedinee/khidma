import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:khidma/constatnts/constants.dart';

class JobRequirementsApi {
  fetchJobRequirements(jobID)async{
    try {
      var req = await http.get(
        Uri.parse('$BASE_URL/api/jobRequirements/fetch/$jobID',)
      );
      print(req.statusCode);
      if (req.statusCode != 200) {
        throw Exception();
      }
      return json.decode(req.body);
    } catch (e) {
      rethrow;
    }
  }
}