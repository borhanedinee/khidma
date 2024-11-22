import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:khidma/constants.dart';

class BookmarksApi {
  addBookmark(userID, jobID) async {
    try {
      var req = await http.post(
        Uri.parse('$BASE_URL/api/bookmarks/add'),
        body: json.encode({
          'userID': userID,
          'jobID': jobID,
        }),
        headers: HEADERS,
      );
      if (req.statusCode == 201) {
        return req.statusCode;
      }
      throw Exception();
    } catch (e) {
      rethrow;
    }
  }

  deleteBookmark(userID, jobID) async {
    try {
      var req = await http.post(Uri.parse('$BASE_URL/api/bookmarks/delete'),
          body: json.encode({
            'userID': userID,
            'jobID': jobID,
          }),
          headers: HEADERS);
      if (req.statusCode == 200) {
        return req.statusCode;
      }
      throw Exception();
    } catch (e) {
      rethrow;
    }
  }

  fetchBookmarks(userID) async {
    try {
      var req = await http.get(
        Uri.parse('$BASE_URL/api/bookmarks/fetch/$userID'),
      );
      if (req.statusCode == 200) {
        return jsonDecode(req.body);
      }
      throw Exception();
    } catch (e) {
      rethrow;
    }
  }
}
