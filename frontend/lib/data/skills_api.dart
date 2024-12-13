import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:khidma/constatnts/constants.dart';

class SkillsAPI {
  // fetch skills
  fetchUserSkills(int userid) async {
    try {
      final response = await http.get(
        Uri.parse('$BASE_URL/api/skills/fetch/$userid'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to load skills');
      }
    } on Exception catch (e) {
      rethrow;
    }
  }

  // add skill
  addSkill(int userid, String skillName) async {
    try {
      var req = await http.post(
        Uri.parse(
          '$BASE_URL/api/skills/add',
        ),
        body: json.encode({
          'skill': skillName,
          'userid': userid,
        }),
        headers: HEADERS,
      );
      if (req.statusCode == 201) {
        return true;
      } else {
        throw Exception('Failed to add skill');
      }
    } catch (e) {
      rethrow;
    }
  }
}
