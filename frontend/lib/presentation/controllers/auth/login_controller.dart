import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/data/user_api.dart';
import 'package:khidma/domain/models/user_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/pages/home_pages/home_page.dart';
import 'package:khidma/presentation/pages/main_page.dart';

class LoginController extends GetxController {
  final UserApi userApi;
  LoginController({required this.userApi});

  // login
  bool isLogingLoading = false;

  login(email, password) async {
    try {
      isLogingLoading = true;
      update();
      await Future.delayed(Durations.extralong4);
      var req = await userApi.login(email, password);
      if (req['status'] == '') {
        throw Exception();
      }
      if (req['status'] == 'success') {
        User user = User.fromJson(req['user']);
        print(user.avatar);
        saveUser(user);
        Get.showSnackbar(
          const GetSnackBar(
            message: 'Logged in successfully.',
            duration: Duration(seconds: 2),
          ),
        );
        Get.off(const MainPage());
      } else if (req['status'] == 'fail') {
        Get.showSnackbar(
          const GetSnackBar(
            message: 'Invalid email or password.',
            duration: Duration(seconds: 2),
          ),
        );
      }
      isLogingLoading = false;
      update();
    } catch (e) {
      isLogingLoading = false;
      update();
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Something went wrong, please try again.',
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
  
  void saveUser(User user) {
    prefs.setString('userfullname', user.fullname);
    prefs.setString('useremail', user.email);
    prefs.setString('userpassword', user.password);
    prefs.setInt('isRecruiter', user.isRecruiter);
    prefs.setString('useravatar', user.avatar);
    prefs.setInt('userid', user.id);
  }
}
