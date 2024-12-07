import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:khidma/constatnts/constants.dart';

class ConversationAPI {
  // fetch conversations
  fetchConversations(int userid) async {
    try {
      final response = await http.get(
        Uri.parse('$BASE_URL/api/conversations/fetch/$userid/'),
        headers: HEADERS,
      );

      if (response.statusCode != 200) {
        throw Exception();
      }
      final jsonResponse = json.decode(response.body);
      return jsonResponse;
    } catch (e) {
      rethrow;
    }
  }
}
