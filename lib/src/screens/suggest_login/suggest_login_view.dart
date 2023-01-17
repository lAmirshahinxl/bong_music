import 'package:bong/src/screens/suggest_login/suggest_login_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../widgets/submit_button.dart';

class SuggestLoginPage extends StatefulWidget {
  const SuggestLoginPage({super.key});

  @override
  State<SuggestLoginPage> createState() => _SuggestLoginPageState();
}

class _SuggestLoginPageState extends State<SuggestLoginPage> {
  final logic = Get.put(SuggestLoginLogic());
  @override
  void dispose() {
    Get.delete<SuggestLoginLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            top: 0,
            bottom: 0,
            child: logic.controller == null
                ? const SizedBox()
                : VideoPlayer(logic.controller!),
          ),
          Positioned(
              right: 0,
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
              )),
          Positioned(
              right: 0,
              left: 0,
              top: 0,
              bottom: 0,
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Image.asset('assets/images/bong_logo.png'),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SubmitButton(
                        text: "Login & Register",
                        onPressed: () {
                          // Get.back();
                          Get.offAndToNamed('/login');
                        },
                        radius: 10,
                        width: Get.width * 0.5,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SubmitButton(
                        text: "Skip",
                        onPressed: () {
                          Get.back();
                        },
                        radius: 10,
                        backgroundColor: Colors.transparent,
                        textColor: Colors.white,
                        width: Get.width * 0.5,
                      )
                    ],
                  )),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ))
        ],
      ),
    );
  }
}
