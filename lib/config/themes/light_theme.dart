import 'package:flutter/material.dart';

abstract class LightAppColors {
  static const primary = Color(0xff000000);
  static const secondary = Color(0xff359B4C);
  static const danger = Color(0xfff9304d);
  static const stable = Color(0xfffafafa);
  static const light = Color(0xfff6f6f6);

  static const cardBackground = Color(0xffffffff);
  static const warningBackground = Color(0xfff9f8e7);

  static const primaryButtonTextColor = Color(0xffffffff);
  static const primaryTextColor = Color(0xff000000);
  static const bottomBarButtons = Color(0xffffffff);
}

final ThemeData lightThemeData = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Roboto',
  primaryColor: LightAppColors.primary,
  scaffoldBackgroundColor: LightAppColors.stable,
  accentColor: LightAppColors.primary,
  textSelectionTheme: const TextSelectionThemeData()
      .copyWith(cursorColor: LightAppColors.primary),
  cardColor: LightAppColors.cardBackground,
  cardTheme: const CardTheme(
    color: LightAppColors.cardBackground,
    shape: RoundedRectangleBorder(
      borderRadius: const BorderRadius.all(Radius.circular(6.0)),
    ),
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: LightAppColors.stable,
    iconTheme: IconThemeData(color: LightAppColors.primary),
    textTheme: TextTheme(
      headline6: TextStyle(
        fontFamily: "Roboto",
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: LightAppColors.primary,
      ),
    ),
  ),
  textTheme: TextTheme(
    headline1: const TextStyle(
      fontFamily: "Roboto",
      fontSize: 112,
      fontWeight: FontWeight.w200,
      color: LightAppColors.primaryTextColor,
    ),
    headline2: const TextStyle(
      fontFamily: "Roboto",
      fontSize: 56,
      fontWeight: FontWeight.w400,
      color: LightAppColors.primaryTextColor,
    ),
    headline3: const TextStyle(
      fontFamily: "Roboto",
      fontSize: 40,
      fontWeight: FontWeight.w500,
      color: LightAppColors.primaryTextColor,
    ),
    headline4: const TextStyle(
      fontFamily: "Roboto",
      fontSize: 34,
      fontWeight: FontWeight.w500,
      color: LightAppColors.primaryTextColor,
    ),
    headline5: const TextStyle(
      fontFamily: "Roboto",
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: LightAppColors.primaryTextColor,
    ),
    headline6: const TextStyle(
      fontFamily: "Roboto",
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: LightAppColors.primaryTextColor,
    ),
    subtitle1: TextStyle(
      fontFamily: "Roboto",
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: LightAppColors.primaryTextColor.withOpacity(0.7),
    ),
    subtitle2: TextStyle(
      fontFamily: "Roboto",
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: LightAppColors.primaryTextColor.withOpacity(0.7),
    ),
    bodyText1: TextStyle(
      fontFamily: "Roboto",
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: LightAppColors.primaryTextColor.withOpacity(0.7),
    ),
    bodyText2: TextStyle(
      fontFamily: "Roboto",
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: LightAppColors.primaryTextColor.withOpacity(0.7),
    ),
    button: TextStyle(
      fontFamily: "Roboto",
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: LightAppColors.primaryTextColor.withOpacity(0.7),
    ),
    caption: TextStyle(
      fontFamily: "Roboto",
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: LightAppColors.primaryTextColor.withOpacity(0.5),
    ),
    overline: const TextStyle(
      fontFamily: "Roboto",
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: LightAppColors.primary,
    ),
  ),
  buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.accent),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: LightAppColors.bottomBarButtons,
    foregroundColor: LightAppColors.bottomBarButtons,
  ),
  iconTheme: const IconThemeData(color: LightAppColors.primary),
  primaryIconTheme: const IconThemeData(color: LightAppColors.primary),
  accentIconTheme: const IconThemeData(color: LightAppColors.cardBackground),
  dividerTheme: DividerThemeData(
    color: LightAppColors.primaryTextColor.withOpacity(0.5),
  ),
);

final lightThemeConfig = {
  'themeData': lightThemeData,
  'primary': LightAppColors.primary,
  'secondaryColor': LightAppColors.secondary,
  'stableColor': LightAppColors.stable,
  'errorColor': LightAppColors.danger,
  'lightColor': LightAppColors.light,
  'inputBoxBorderColor': LightAppColors.primaryTextColor.withOpacity(0.5),
  'placeHolderTextColor': LightAppColors.primaryTextColor.withOpacity(0.4),
  'warningBackground': LightAppColors.warningBackground,
  'primaryButtonTextColor': LightAppColors.primaryButtonTextColor,
  'primaryTextColor': LightAppColors.primaryTextColor
};
