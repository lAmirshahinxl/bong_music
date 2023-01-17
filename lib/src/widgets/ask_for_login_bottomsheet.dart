import 'package:bong/src/config/color_constants.dart';
import 'package:bong/src/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AskForLoginBottomsheet extends StatelessWidget {
  const AskForLoginBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.7,
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorConstants.backgroundColor,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10))),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 100,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(10)),
          ),
          const SizedBox(
            height: 30,
          ),
          SvgPicture.asset(
            'assets/icons/account-login.svg',
            width: 200,
            height: 200,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Login and access all the features of the Bong music',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.grey, fontFamily: ''),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SubmitButton(
                text: "Login & Register",
                onPressed: () {
                  Get.back();
                  Get.toNamed('/login');
                },
                radius: 10,
                width: Get.width - 20,
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
                backgroundColor: Colors.grey,
                width: Get.width - 20,
              )
            ],
          )),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
