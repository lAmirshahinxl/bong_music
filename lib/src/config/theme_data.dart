import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color_constants.dart';

class ThemeConfig {
  static ThemeData createTheme({
    required Brightness brightness,
    required Color background,
    required Color primaryText,
    required Color secondaryText,
    required Color accentColor,
    required Color divider,
    required Color buttonBackground,
    required Color buttonText,
    required Color cardBackground,
    required Color disabled,
    required Color error,
    required Color textButtonColor,
    required Color hintColor,
    required Color textFieldColor,
    required Color checkBoxColor,
    required Color iconColor,
    required Color textLargeColorAppBar,
  }) {
    final baseTextTheme = brightness == Brightness.dark
        ? Typography.blackMountainView
        : Typography.whiteMountainView;

    return ThemeData(
      brightness: brightness,
      buttonColor: buttonBackground,
      canvasColor: background,
      cardColor: background,
      dividerColor: divider,
      dividerTheme: DividerThemeData(
        color: divider,
        space: 1,
        thickness: 1,
      ),
      cardTheme: CardTheme(
        color: cardBackground,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
      ),
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all<Color>(checkBoxColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      backgroundColor: background,
      primaryColor: accentColor,
      accentColor: accentColor,
      toggleableActiveColor: accentColor,
      appBarTheme: AppBarTheme(
        brightness: brightness,
        color: cardBackground,
        textTheme: TextTheme(bodyLarge: TextStyle(color: textLargeColorAppBar)),
        iconTheme: IconThemeData(
          color: iconColor,
        ),
      ),
      iconTheme: IconThemeData(
        color: secondaryText,
        size: 16.0,
      ),
      errorColor: error,
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        colorScheme: ColorScheme(
          brightness: brightness,
          primary: accentColor,
          primaryVariant: accentColor,
          secondary: accentColor,
          secondaryVariant: accentColor,
          surface: background,
          background: background,
          error: error,
          onPrimary: buttonText,
          onSecondary: buttonText,
          onSurface: buttonText,
          onBackground: buttonText,
          onError: buttonText,
        ),
        padding: const EdgeInsets.all(16.0),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            primary: textButtonColor,
            textStyle: baseTextTheme.headline4!.copyWith(
              color: primaryText,
              fontFamily: 'iran',
            )),
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: brightness,
        primaryColor: accentColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        errorStyle: TextStyle(color: error),
        labelStyle: TextStyle(
          fontFamily: 'iran',
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
          color: primaryText.withOpacity(0.5),
        ),
        hintStyle: TextStyle(
          color: hintColor,
          fontSize: 13.0,
          fontWeight: FontWeight.w300,
        ),
        contentPadding: const EdgeInsets.all(0),
        fillColor: Colors.white,
        filled: true,
      ),
      fontFamily: 'iran',
      textTheme: TextTheme(
        headline1: baseTextTheme.headline1!.copyWith(
            color: primaryText,
            fontSize: 34.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'iran'),
        headline2: baseTextTheme.headline2!.copyWith(
          color: primaryText,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          fontFamily: 'iran',
        ),
        headline3: baseTextTheme.headline3!.copyWith(
          color: secondaryText,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'iran',
        ),
        headline4: baseTextTheme.headline4!.copyWith(
          color: primaryText,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'iran',
        ),
        headline5: baseTextTheme.headline5!.copyWith(
          color: primaryText,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          fontFamily: 'iran',
        ),
        headline6: baseTextTheme.headline6!.copyWith(
          color: primaryText,
          fontSize: 14,
          fontWeight: FontWeight.w700,
          fontFamily: 'iran',
        ),
        bodyText1: baseTextTheme.bodyText1!.copyWith(
          color: textFieldColor,
          fontSize: 15,
          fontFamily: 'iran',
        ),
        bodyText2: baseTextTheme.bodyText2!.copyWith(
          color: primaryText,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontFamily: 'iran',
        ),
        button: baseTextTheme.button!.copyWith(
          color: primaryText,
          fontSize: 12.0,
          fontWeight: FontWeight.w700,
          fontFamily: 'iran',
        ),
        caption: baseTextTheme.caption!.copyWith(
          color: primaryText,
          fontSize: 11.0,
          fontWeight: FontWeight.w300,
          fontFamily: 'iran',
        ),
        overline: baseTextTheme.overline!.copyWith(
          color: secondaryText,
          fontSize: 11.0,
          fontWeight: FontWeight.w500,
          fontFamily: 'iran',
        ),
        subtitle1: baseTextTheme.subtitle1!.copyWith(
          color: primaryText,
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
          fontFamily: 'iran',
        ),
        subtitle2: baseTextTheme.subtitle2!.copyWith(
          color: secondaryText,
          fontSize: 11.0,
          fontWeight: FontWeight.w500,
          fontFamily: 'iran',
        ),
      ),
    );
  }

  static ThemeData get lightTheme => createTheme(
      brightness: Brightness.light,
      background: ColorConstants.lightScaffoldBackgroundColor,
      cardBackground: Colors.white,
      primaryText: Colors.black,
      secondaryText: Colors.white,
      accentColor: ColorConstants.secondaryAppColor,
      divider: ColorConstants.secondaryAppColor,
      buttonBackground: Colors.black38,
      buttonText: ColorConstants.secondaryAppColor,
      disabled: ColorConstants.secondaryAppColor,
      error: Colors.red,
      textButtonColor: Colors.black,
      hintColor: hexToColor('#8C8C8C'),
      textFieldColor: Colors.black,
      checkBoxColor: Colors.black,
      iconColor: Colors.black,
      textLargeColorAppBar: Colors.black);

  static ThemeData get darkTheme => createTheme(
      brightness: Brightness.dark,
      background: const Color(0xff303030),
      cardBackground: const Color.fromARGB(174, 44, 44, 44),
      primaryText: Colors.white,
      secondaryText: Colors.white,
      accentColor: ColorConstants.secondaryDarkAppColor,
      divider: const Color(0xff707070),
      buttonBackground: Colors.white,
      buttonText: ColorConstants.secondaryDarkAppColor,
      disabled: ColorConstants.secondaryDarkAppColor,
      error: Colors.red,
      textButtonColor: Colors.white,
      hintColor: hexToColor('#8C8C8C'),
      textFieldColor: Colors.black,
      checkBoxColor: Colors.black,
      iconColor: Colors.white,
      textLargeColorAppBar: Colors.white);
}
