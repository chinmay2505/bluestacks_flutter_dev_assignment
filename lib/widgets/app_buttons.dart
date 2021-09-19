import 'package:flutter/material.dart';
import 'package:bluestacks_flutter_dev_assignment/config/themes/bloc/bloc.dart';
import 'package:bluestacks_flutter_dev_assignment/config/themes/theme_config.dart';

/// This class is used to make the primary buttons in the application.
/// Button type: Elevated button with text and icon button with text.
/// Required parameters: Text, callback when the button is pressed.
class AppElevatedButton extends StatelessWidget {
  final Key? key;
  final ThemeState themeState;
  final String message;
  final VoidCallback? onPressed;
  final double? borderRadius;
  final Color? color;
  final double? minWidth;
  final Color? textColor;
  final TextStyle? textStyle;

  const AppElevatedButton({
    this.key,
    required this.themeState,
    required this.message,
    required this.onPressed,
    this.borderRadius,
    this.minWidth,
    this.color,
    this.textColor,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: minWidth ?? AppScreenConfig.screenWidth! * 0.6,
      height: 40.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            color: color ?? Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          ),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: minWidth ?? AppScreenConfig.screenWidth! * 0.6,
              minHeight: 40.0,
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: _getButtonWithTextOnly(context, message),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getButtonWithTextOnly(BuildContext context, String message) {
    return Text(
      message.toUpperCase(),
      textAlign: TextAlign.center,
      style: getTextStyle(context),
    );
  }

  TextStyle getTextStyle(BuildContext context) {
    if (textStyle != null) {
      return textStyle!;
    } else if (textColor == null) {
      return color == null
          ? TextStyle(
              color: themeState.themeData['primaryButtonTextColor'] as Color)
          : (Theme.of(context).brightness == Brightness.light)
              ? TextStyle(
                  color:
                      themeState.themeData['primaryButtonTextColor'] as Color)
              : TextStyle(color: Theme.of(context).primaryColor);
    } else {
      return TextStyle(color: textColor);
    }
  }
}
