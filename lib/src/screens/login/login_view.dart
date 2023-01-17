import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:bong/src/config/color_constants.dart';
import 'package:bong/src/screens/login/login_logic.dart';
import 'package:bong/src/screens/splash/splash_logic.dart';
import 'package:bong/src/utils/utils.dart';
import 'package:bong/src/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final logic = Get.put(LoginLogic());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Hero(
            tag: 'setting9',
            child: FittedBox(
              fit: BoxFit.fill,
              child: SizedBox(
                height: 90,
                width: Get.width,
                child: Card(
                  elevation: 1,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: true,
                            child: IconButton(
                              onPressed: Get.back,
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                          Obx(
                            () => Text(
                              logic.splashLogic.currentLanguage['login'],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 20),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_back_ios,
                                color: Colors.transparent),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Lottie.asset(
            'assets/lottie/hello.json',
            width: 200,
            height: 200,
            repeat: false,
            animate: false,
            onLoaded: (p0) {
              // logic.animationController
              //   ..duration = p0.duration
              //   ..forward();
            }, /*controller: logic.animationController*/
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: logic.emailController,
              textInputAction: TextInputAction.next,
              decoration: defTextfieldDecoration().copyWith(
                  hintText: logic.splashLogic.currentLanguage['email']),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: logic.passwordController,
                obscureText: true,
                textInputAction: logic.accountState.value == AccountState.login
                    ? TextInputAction.done
                    : TextInputAction.next,
                onSubmitted: (value) {
                  if (logic.accountState.value == AccountState.login) {
                    logic.callLogicApi();
                  }
                },
                decoration: defTextfieldDecoration().copyWith(
                    hintText: logic.splashLogic.currentLanguage['password']),
              ),
            ),
          ),
          Obx(
            () => AnimatedSizeAndFade.showHide(
              show: logic.accountState.value == AccountState.register,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: logic.rePasswordController,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      decoration: defTextfieldDecoration().copyWith(
                          hintText:
                              logic.splashLogic.currentLanguage['rePassword']),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: logic.phoneController,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(fontFamily: ''),
                      decoration: defTextfieldDecoration().copyWith(
                          hintText: logic.splashLogic.currentLanguage['phone']),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: logic.nameController,
                      onSubmitted: (value) {
                        if (logic.accountState.value == AccountState.register) {
                          logic.callRegisterApi();
                        }
                      },
                      style: const TextStyle(fontFamily: ''),
                      decoration: defTextfieldDecoration().copyWith(
                          hintText: logic.splashLogic.currentLanguage['name']),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => SubmitButton(
                    text: logic.accountState.value == AccountState.login
                        ? logic.splashLogic.currentLanguage['login']
                        : logic.splashLogic.currentLanguage['register'],
                    onPressed: () {
                      if (logic.accountState.value == AccountState.login) {
                        logic.callLogicApi();
                      } else {
                        logic.callRegisterApi();
                      }
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => AnimatedSwitcherFlip.flipY(
                  duration: const Duration(seconds: 1),
                  child: logic.accountState.value == AccountState.login
                      ? SizedBox(
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                logic.splashLogic
                                    .currentLanguage['notHaveAccount'],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black),
                              ),
                              TextButton(
                                onPressed: () =>
                                    logic.changeState(AccountState.register),
                                child: Text(
                                  logic.splashLogic.currentLanguage['register'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: ColorConstants.gold),
                                ),
                              )
                            ],
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              logic.splashLogic
                                  .currentLanguage['areHaveAccount'],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                            ),
                            TextButton(
                              onPressed: () =>
                                  logic.changeState(AccountState.login),
                              child: Text(
                                logic.splashLogic.currentLanguage['login'],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: ColorConstants.gold),
                              ),
                            )
                          ],
                        ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    logic.splashLogic.currentLanguage['areForgetPassword'],
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      EasyLoading.showToast("Not working");
                    },
                    child: Text(
                      logic.splashLogic.currentLanguage['recovery'],
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: ColorConstants.gold),
                    ),
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
