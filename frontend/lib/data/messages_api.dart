import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:khidma/constatnts/constants.dart';

class MessagesAPI {
  // fetch messages
  fetchMessages(int conversationid) async {
    try {
      var response = await http.get(
        Uri.parse(
          '$BASE_URL/api/messages/fetch/$conversationid',
        ),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to fetch messages');
      }
    } catch (error) {
      rethrow;
    }
  }

  // mark all messages as read
  markAllMessagesAsRead(int conversationid, int senderid) async {
    try {
      var response = await http.post(
        Uri.parse('$BASE_URL/api/messages/markallmessagesasread'),
        body: json.encode(
          {'conversationid': conversationid, 'senderid': senderid},
        ),
        headers: HEADERS,
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to mark messages as read');
      }
    } catch (error) {
      rethrow;
    }
  }
}
