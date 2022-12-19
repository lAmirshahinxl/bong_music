import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'config/string_constants.dart';
import 'config/theme_data.dart';
import 'routes/index.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appName,
      theme: ThemeConfig.lightTheme,
      darkTheme: ThemeConfig.darkTheme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: routes,
      themeMode:
          GetStorage().read('theme') == 0 ? ThemeMode.dark : ThemeMode.light,
      builder: EasyLoading.init(),
    );
  }
}
