import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../config/color_constants.dart';

SpinKitSquareCircle spinKit() {
  return const SpinKitSquareCircle(
    color: Colors.blue,
    size: 30.0,
  );
}

SpinKitFadingCircle splashSpinKit() {
  return const SpinKitFadingCircle(
    color: Colors.blue,
    size: 50.0,
  );
}

SnackbarController showSnackBar(String title, String message,
    {Color? backgroundColor}) {
  if (backgroundColor == null) {
    return Get.showSnackbar(GetSnackBar(
      title: title,
      message: message,
      isDismissible: true,
      duration: const Duration(seconds: 2),
    ));
  } else {
    return Get.showSnackbar(GetSnackBar(
      title: title,
      message: message,
      isDismissible: true,
      duration: const Duration(seconds: 2),
      backgroundColor: backgroundColor,
    ));
  }
}

extension Ex on double {
  double toRound(int n) => double.parse(toStringAsFixed(n));
  String zeroRound({bool seRagham = false}) {
    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
    String s = toString().replaceAll(regex, '');
    if (seRagham) return s.seRagham();
    return s;
  }
}

extension Exx on String {
  String zeroRound({bool seRagham = false}) {
    RegExp regex = RegExp(r'(?!.*\d)');
    String s = toString().replaceAll(regex, '');
    if (seRagham) return s.seRagham();
    return s;
  }
}

InputDecoration defTextfieldDecoration() {
  return InputDecoration(
      hintText: '',
      labelStyle: TextStyle(color: ColorConstants.gold),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: ColorConstants.gold,
          )),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: ColorConstants.gold,
          )),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: ColorConstants.gold,
          )),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: ColorConstants.gold,
          )),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: ColorConstants.gold,
          )),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.2));
}

Future<String?> getDownloadPath() async {
  Directory? directory;
  try {
    if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = Directory('/storage/emulated/0/Download');
      // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
      // ignore: avoid_slow_async_io
      if (!await directory.exists()) {
        directory = await getExternalStorageDirectory();
      }
    }
  } catch (err, stack) {
    print("Cannot get download folder path");
  }
  return directory?.path;
}

Future<String?> getAppPath() async {
  Directory? directory;
  try {
    directory = await getApplicationDocumentsDirectory();
  } catch (err, stack) {
    print("Cannot get download folder path");
  }
  return directory?.path;
}
