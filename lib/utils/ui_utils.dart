import 'package:flutter/material.dart';
import 'package:bluestacks_flutter_dev_assignment/config/themes/theme_config.dart';
import 'package:bluestacks_flutter_dev_assignment/config/themes/bloc/bloc.dart';

class AppSizedBoxSpacing extends StatelessWidget {
  final double heightSpacing;
  final double widthSpacing;

  const AppSizedBoxSpacing(
      {this.heightSpacing = AppSpacing.l, this.widthSpacing = 0.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightSpacing,
      width: widthSpacing,
    );
  }
}

/// UI Utils class for App Input Label
class AppInputLabelText extends StatelessWidget {
  final Key? key;
  final String labelText;
  final ThemeState themeState;
  final double leftSpacing;
  final bool isErrorLabel;

  const AppInputLabelText({
    this.key,
    required this.labelText,
    required this.themeState,
    this.leftSpacing = 10.0,
    this.isErrorLabel = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: leftSpacing),
      child: Text(
        labelText,
        textAlign: TextAlign.left,
        style: (!isErrorLabel)
            ? Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.w500)
            : Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: themeState.themeData['errorColor'] as Color),
      ),
    );
  }
}

/// UI Utils class for App Input Box
class AppInputForm extends StatelessWidget {
  final Key? key;
  final ThemeState themeState;
  final String placeholderText;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final String? errorText;
  final IconData? icon;
  final bool obscureText;
  final bool enabled;
  final ValueChanged<String>? onChanged;

  const AppInputForm({
    this.key,
    required this.themeState,
    required this.placeholderText,
    required this.controller,
    this.textInputType,
    this.icon,
    this.errorText,
    this.obscureText = false,
    this.enabled = true,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 51.0,
          decoration: _getInputFormDecoration(context, themeState, errorText),
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: <Widget>[
              if (icon != null) ...[
                DisplayInputBoxIcon(themeState: themeState, iconData: icon),
                VerticalPartition(themeState: themeState),
              ],
              if (icon == null)
                Container(margin: const EdgeInsets.only(right: 10.0)),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  keyboardType: textInputType,
                  obscureText: obscureText,
                  enabled: enabled,
                  cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: placeholderText,
                    hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: themeState.themeData['placeHolderTextColor']
                              as Color,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (errorText?.isNotEmpty ?? false)
          AppInputLabelText(
            labelText: errorText!,
            themeState: themeState,
            isErrorLabel: true,
          ),
      ],
    );
  }

  BoxDecoration _getInputFormDecoration(
      BuildContext context, ThemeState themeState, String? errorText) {
    return BoxDecoration(
      border: Border.all(
        color: (errorText?.isEmpty ?? true)
            ? themeState.themeData['inputBoxBorderColor'] as Color
            : themeState.themeData['errorColor'] as Color,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(10.0),
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.transparent
          : themeState.themeData['warningBackground'] as Color,
    );
  }
}

/// UI Utils classes
class VerticalPartition extends StatelessWidget {
  final ThemeState themeState;
  const VerticalPartition({Key? key, required this.themeState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      width: 1.0,
      color: themeState.themeData['placeHolderTextColor'] as Color,
      margin: const EdgeInsets.only(right: 10.0),
    );
  }
}

class DisplayInputBoxIcon extends StatelessWidget {
  final ThemeState themeState;
  final IconData? iconData;
  const DisplayInputBoxIcon({Key? key, required this.themeState, this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Icon(
        iconData ?? Icons.search,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
