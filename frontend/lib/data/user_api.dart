import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:khidma/constatnts/constants.dart';

class UserApi {
  //login
  login(email, password) async {
    var body = {
      'email': email,
      'password': password,
    };
    var req = await http.post(Uri.parse('$BASE_URL/api/auth/login'),
        body: jsonEncode(body), headers: HEADERS);

    if (req.statusCode == 200) {
      print('object');
      var jsonResponse = json.decode(req.body);
      return jsonResponse;
    } else {
      print('ak hnaa');
      throw Exception();
    }
  }

  //signup
  signup(fullname, email, password) {}
}
