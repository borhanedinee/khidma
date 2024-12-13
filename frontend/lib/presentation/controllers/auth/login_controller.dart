import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma/data/user_api.dart';
import 'package:khidma/domain/models/user_model.dart';
import 'package:khidma/main.dart';
import 'package:khidma/presentation/controllers/chat/chats_controller.dart';
import 'package:khidma/presentation/pages/home_pages/home_page.dart';
import 'package:khidma/presentation/pages/main_page.dart';
import 'package:khidma/presentation/services/authentication.dart';
import 'package:khidma/presentation/services/get_saved_user.dart';

class LoginController extends GetxController {
  final SocketService socketService;
  final UserApi userApi;
  LoginController({
    required this.userApi,
    required this.socketService,
  });

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
        UserModel user = UserModel.fromJson(req['user']);
        saveUser(user);
        Get.showSnackbar(
          const GetSnackBar(
            message: 'Logged in successfully.',
            duration: Duration(seconds: 2),
          ),
        );
        socketService.connectUser(getSavedUser().id);
        AuthenticationService.updateIsUserAuthenticated(true);

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
      print(e.toString());
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

  //fetching user data to update prefs in case anything had changed
  loginFromSharedPreference(email, password) async {
    try {
      var req = await userApi.login(email, password);
      if (req['status'] == '') {
        throw Exception();
      }
      if (req['status'] == 'success') {
        UserModel user = UserModel.fromJson(req['user']);
        saveUser(user);
        AuthenticationService.updateIsUserAuthenticated(true);

        socketService.connectUser(getSavedUser().id);
      } else if (req['status'] == 'fail') {
        Get.showSnackbar(
          const GetSnackBar(
            message: 'Invalid email or password.',
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Something went wrong updating user data',
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void saveUser(UserModel user) {
    prefs.setString('userfullname', user.fullname);
    prefs.setString('useremail', user.email);
    prefs.setString('userpassword', user.password);
    prefs.setInt('userphone', user.phone);
    prefs.setBool('isrecruiter', user.isRecruiter);
    prefs.setString('useravatar', user.avatar);

    // DEFAULT VALUE OF user_resume IN DB IS 'none' just to easily
    //track user_resume
    if (user.resume == 'none') {
      prefs.setBool('dbgotresume', false);
    } else {
      prefs.setBool('dbgotresume', true);
      prefs.setString('userremoteresume', user.resume);
      prefs.setBool('userremoteresumeISNOTchanged', true);
    }
    prefs.setInt('userid', user.id);
  }
}
