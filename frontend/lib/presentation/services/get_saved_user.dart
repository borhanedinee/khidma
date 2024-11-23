import 'package:khidma/domain/models/user_model.dart';
import 'package:khidma/main.dart';

User getSavedUser() {
  return User(
    id: prefs.getInt('userid')!,
    email: prefs.getString('useremail')!,
    password: prefs.getString('userpassword')!,
    fullname: prefs.getString('userfullname')!,
    avatar: prefs.getString('useravatar')!,
    isRecruiter: prefs.getBool('isrecruiter')!,
  );
}
