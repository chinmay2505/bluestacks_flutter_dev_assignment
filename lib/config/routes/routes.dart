import 'package:flutter/material.dart';

import 'package:bluestacks_flutter_dev_assignment/core/login/login_screen.dart';
import 'package:bluestacks_flutter_dev_assignment/modules/home/home_screen.dart';

class Routes {
  static const home = '/';
  static const login = '/login';
}

Map<String, WidgetBuilder> appRoutes = {
  Routes.login: (context) => const LoginScreen(),
  Routes.home: (context) => const HomeScreen()
};
