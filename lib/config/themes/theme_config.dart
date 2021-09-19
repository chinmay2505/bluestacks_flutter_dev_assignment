import 'package:flutter/material.dart';

abstract class SetAppScreenConfiguration {
  static late BuildContext context;

  static void init(BuildContext ctx) {
    context = ctx;
    AppScreenConfig.init(context);
  }
}

abstract class AppScreenConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;
  static double? statusbarHeight;
  static double? systemNavbarHeight;

  static double? safeAreaHorizontal;
  static double? safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;
    statusbarHeight = _mediaQueryData!.padding.top;
    systemNavbarHeight = _mediaQueryData!.padding.bottom;

    safeAreaHorizontal =
        _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
    safeAreaVertical =
        _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;
    safeBlockHorizontal = (screenWidth! - safeAreaHorizontal!) / 100;
    safeBlockVertical = (screenHeight! - safeAreaVertical!) / 100;
  }
}

abstract class AppSpacing {
  static const xsss = 2.0;
  static const xss = 4.0;
  static const xs = 8.0;
  static const ms = 10.0;
  static const s = 12.0;
  static const m = 16.0;
  static const l = 20.0;
  static const xl = 24.0;
  static const xxl = 28.0;
  static const xxxl = 32.0;
  static const xxxxl = 36.0;
}
