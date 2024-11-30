import 'package:khidma/domain/models/user_model.dart';
import 'package:khidma/main.dart';

UserModel getSavedUser() {
  return UserModel(
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
