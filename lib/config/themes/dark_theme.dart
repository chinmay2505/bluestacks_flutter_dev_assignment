import 'package:flutter/material.dart';

abstract class DarkAppColors {
  static const primary = Color(0xffffffff);
  static const secondary = Color(0xff359B4C);
  static const danger = Color(0xfff9304d);
  static const stable = Color(0xff26283c);
  static const light = Color(0xfff6f6f6);

  static const cardBackground = Color(0xff393a4c);
  static const warningBackground = Color(0xff393a4c);

  static const primaryButtonTextColor = Color(0xff1c1e30);
  static const primaryTextColor = Color(0xffffffff);
  static const bottomBarButtons = Color(0xff1c1e30);
}

final ThemeData darkThemeData = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Roboto',
  primaryColor: DarkAppColors.primary,
  scaffoldBackgroundColor: DarkAppColors.stable,
  accentColor: DarkAppColors.primary,
  textSelectionTheme: const TextSelectionThemeData()
      .copyWith(cursorColor: DarkAppColors.primary),
  cardColor: DarkAppColors.cardBackground,
  cardTheme: const CardTheme(
    color: DarkAppColors.cardBackground,
    shape: const RoundedRectangleBorder(
      borderRadius: const BorderRadius.all(Radius.circular(6.0)),
    ),
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: DarkAppColors.stable,
    iconTheme: IconThemeData(color: DarkAppColors.primary),
    textTheme: TextTheme(
      headline6: TextStyle(
        fontFamily: "Roboto",
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: DarkAppColors.primary,
      ),
    ),
  ),
  textTheme: TextTheme(
    headline1: const TextStyle(
      fontFamily: "Roboto",
      fontSize: 112,
      fontWeight: FontWeight.w200,
      color: DarkAppColors.primaryTextColor,
    ),
    headline2: const TextStyle(
      fontFamily: "Roboto",
      fontSize: 56,
      fontWeight: FontWeight.w400,
      color: DarkAppColors.primaryTextColor,
    ),
    headline3: const TextStyle(
      fontFamily: "Roboto",
      fontSize: 40,
      fontWeight: FontWeight.w500,
      color: DarkAppColors.primaryTextColor,
    ),
    headline4: const TextStyle(
      fontFamily: "Roboto",
      fontSize: 34,
      fontWeight: FontWeight.w500,
      color: DarkAppColors.primaryTextColor,
    ),
    headline5: const TextStyle(
      fontFamily: "Roboto",
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: DarkAppColors.primaryTextColor,
    ),
    headline6: const TextStyle(
      fontFamily: "Roboto",
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: DarkAppColors.primaryTextColor,
    ),
    subtitle1: TextStyle(
      fontFamily: "Roboto",
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: DarkAppColors.primaryTextColor.withOpacity(0.7),
    ),
    subtitle2: TextStyle(
      fontFamily: "Roboto",
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: DarkAppColors.primaryTextColor.withOpacity(0.7),
    ),
    bodyText1: TextStyle(
      fontFamily: "Roboto",
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: DarkAppColors.primaryTextColor.withOpacity(0.7),
    ),
    bodyText2: TextStyle(
      fontFamily: "Roboto",
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: DarkAppColors.primaryTextColor.withOpacity(0.7),
    ),
    button: TextStyle(
      fontFamily: "Roboto",
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: DarkAppColors.primaryTextColor.withOpacity(0.7),
    ),
    caption: TextStyle(
      fontFamily: "Roboto",
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: DarkAppColors.primaryTextColor.withOpacity(0.5),
    ),
    overline: const TextStyle(
      fontFamily: "Roboto",
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: DarkAppColors.primary,
    ),
  ),
  buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.accent),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: DarkAppColors.bottomBarButtons,
    foregroundColor: DarkAppColors.bottomBarButtons,
  ),
  iconTheme: const IconThemeData(color: DarkAppColors.primary),
  primaryIconTheme: const IconThemeData(color: DarkAppColors.primary),
  accentIconTheme:
      const IconThemeData(color: DarkAppColors.primaryButtonTextColor),
  dividerTheme: DividerThemeData(
    color: DarkAppColors.primaryTextColor.withOpacity(0.5),
  ),
);

final darkThemeConfig = {
  'themeData': darkThemeData,
  'primary': DarkAppColors.primary,
  'secondaryColor': DarkAppColors.secondary,
  'stableColor': DarkAppColors.stable,
  'errorColor': DarkAppColors.danger,
  'lightColor': DarkAppColors.light,
  'inputBoxBorderColor': DarkAppColors.primaryTextColor.withOpacity(0.5),
  'placeHolderTextColor': DarkAppColors.primaryTextColor.withOpacity(0.4),
  'warningBackground': DarkAppColors.warningBackground,
  'primaryButtonTextColor': DarkAppColors.primaryButtonTextColor,
  'primaryTextColor': DarkAppColors.primaryTextColor
};
