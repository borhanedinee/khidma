import 'package:khidma/domain/models/user_model.dart';
import 'package:khidma/main.dart';

User getSavedUser() {
  return User(
    id: prefs.getInt('userid')!,
    email: prefs.getString('useremail')!,
    phone: prefs.getInt('userphone')!,
    password: prefs.getString('userpassword')!,
    fullname: prefs.getString('userfullname')!,
    avatar: prefs.getString('useravatar')!,
    resume: prefs.getString('userremoteresume') ?? '',
    isRecruiter: prefs.getBool('isrecruiter')!,
  );
}
