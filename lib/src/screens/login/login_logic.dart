import 'package:bong/src/core/models/login_model.dart';
import 'package:bong/src/core/services/services.dart';
import 'package:bong/src/screens/profile/profile_logic.dart';
import 'package:bong/src/screens/splash/splash_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

enum AccountState { login, register }

class LoginLogic extends GetxController with GetSingleTickerProviderStateMixin {
  final splashLogic = Get.find<SplashLogic>();
  Rx<AccountState> accountState = AccountState.login.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  // late AnimationController animationController;
  @override
  void onInit() {
    super.onInit();
    // animationController = AnimationController(vsync: this);
  }

  @override
  void onClose() {
    // animationController.dispose();
    super.onClose();
  }

  void changeState(AccountState state) {
    // animationController.reset();
    // animationController.forward();
    accountState.value = state;
  }

  void callLogicApi() async {
    if (!emailController.text.isEmail) {
      EasyLoading.showToast("Email is not correct");
      return;
    }
    if (passwordController.text.length < 6) {
      EasyLoading.showToast("Password is not correct");
      return;
    }
    EasyLoading.show(status: "Please Wait");
    var res = await RemoteService()
        .login(emailController.text, passwordController.text);
    EasyLoading.dismiss();
    if (res[0] == null) {
      EasyLoading.showToast(res[1]);
      return;
    }
    LoginModel loginModel = res[0];
    GetStorage().write('token', loginModel.token);
    GetStorage().write('email', loginModel.user.email);
    try {
      final profileLogic = Get.find<ProfileLogic>();
      profileLogic.tabListStatics.last = {
        "name": GetStorage().hasData('token')
            ? splashLogic.currentLanguage['logout']
            : splashLogic.currentLanguage['login'],
        "icon": Icons.login_rounded
      };
    } catch (e) {}
    Get.offAndToNamed('/select_artist');
  }

  void callRegisterApi() async {
    if (!emailController.text.isEmail) {
      EasyLoading.showToast("Email is not correct");
      return;
    }
    if (passwordController.text.length < 6) {
      EasyLoading.showToast("Password is not correct");
      return;
    }

    if (!passwordController.text.contains(rePasswordController.text)) {
      EasyLoading.showToast("Password and repeat password is not match");
      return;
    }

    if (phoneController.text.length < 11) {
      EasyLoading.showToast("Phone number must be 11 characters");
      return;
    }

    EasyLoading.show(status: "Please Wait");
    bool success = await RemoteService().register(
        emailController.text,
        passwordController.text,
        phoneController.text,
        nameController.text,
        birthdayController.text);
    EasyLoading.dismiss();
    if (success) {
      EasyLoading.showToast("Register Success, Please Login");
      accountState.value = AccountState.login;
    } else {
      EasyLoading.showToast("Register Error, Check Inputs Data");
    }
  }
}
