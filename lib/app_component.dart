import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:bluestacks_flutter_dev_assignment/utils/services/app_localization.dart';
import 'package:bluestacks_flutter_dev_assignment/config/routes/routes.dart';
import 'package:bluestacks_flutter_dev_assignment/config/themes/bloc/bloc.dart';
import 'package:bluestacks_flutter_dev_assignment/config/themes/dark_theme.dart';
import 'package:bluestacks_flutter_dev_assignment/config/themes/light_theme.dart';
import 'package:bluestacks_flutter_dev_assignment/app_constants.dart';
import 'package:bluestacks_flutter_dev_assignment/application.dart';

class AppComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (_) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) => const AppComponentStateful(),
      ),
    );
  }
}

class AppComponentStateful extends StatefulWidget {
  const AppComponentStateful();

  @override
  State<StatefulWidget> createState() => AppComponentState();
}

class AppComponentState extends State<AppComponentStateful>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    /// Register with the widget layer binding
    WidgetsBinding.instance!.addObserver(this);

    /// Fetch the platform Brightness from the widget layer
    final Brightness _brightness =
        WidgetsBinding.instance!.window.platformBrightness;

    /// Add event of Theme Changed into the ThemeBloc if current theme of a
    /// platform is in dark mode as by default the light theme is yield from
    /// the ThemeBloc.
    if (_brightness == Brightness.dark) {
      BlocProvider.of<ThemeBloc>(context)
          .add(const ThemeChanged(isDarkMode: true));
    }
  }

  @override
  void dispose() {
    /// Remove the register with the widget layer binding
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  /// The below method is called when the theme of a device is changed
  /// while the app is in memory / Open
  @override
  void didChangePlatformBrightness() {
    final Brightness _brightness =
        WidgetsBinding.instance!.window.platformBrightness;

    /// Add the theme changed event
    BlocProvider.of<ThemeBloc>(context)
        .add(ThemeChanged(isDarkMode: _brightness == Brightness.dark));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleApplicationOnTapScreen(context),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightThemeData,
        darkTheme: darkThemeData,
        themeMode: ThemeMode.system,
        supportedLocales: AppConstants.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        initialRoute:
            Application.isUserLoggedIn && Application.logInUsername.isNotEmpty
                ? Routes.home
                : Routes.login,
        routes: appRoutes,
      ),
    );
  }

  /// Remove the keyboard when tapped on any part of screen other than primary
  /// focus
  void _handleApplicationOnTapScreen(BuildContext context) {
    FocusScopeNode _currentFocus = FocusScope.of(context);
    if (!_currentFocus.hasPrimaryFocus) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
  }
}
