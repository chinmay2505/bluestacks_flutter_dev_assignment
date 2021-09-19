import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bluestacks_flutter_dev_assignment/application.dart';
import 'package:bluestacks_flutter_dev_assignment/app_bloc_observer.dart';
import 'package:bluestacks_flutter_dev_assignment/utils/services/local_storage_service.dart';
import 'package:bluestacks_flutter_dev_assignment/utils/services/rest_api_service.dart';
import 'package:bluestacks_flutter_dev_assignment/app_component.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Create the instances of the singleton classes
  Application.storageService = await LocalStorageService.getInstance();
  Application.restService = RestAPIService.getInstance();

  /// User is already logged in or not from the storageService
  Application.isUserLoggedIn = Application.storageService!.isUserLoggedIn;

  /// Log in username from the storageService
  Application.logInUsername = Application.storageService!.loggedInUsername;

  /// Observe the behavior of [Bloc]
  Bloc.observer = AppBlocObserver();

  runApp(AppComponent());
}
