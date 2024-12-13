import 'package:khidma/main.dart';

class AuthenticationService {
  static updateIsUserAuthenticated(bool value) {
    prefs.setBool('isauthenticated', value);
  }

  static bool isUserAuthenticated() {
    return prefs.getBool('isauthenticated') ?? false;
  }
}
