import 'dart:io';

import 'package:flutter/material.dart';

import 'package:bluestacks_flutter_dev_assignment/utils/services/local_storage_service.dart';
import 'package:bluestacks_flutter_dev_assignment/utils/services/rest_api_service.dart';

class Application {
  /// To assign and hold the instance of singleton class LocalStorageService
  static LocalStorageService? storageService;

  /// assign and hold the instance of singleton class RestAPIService
  static RestAPIService? restService;

  /// Detect the target platform
  static TargetPlatform platform =
      Platform.isIOS ? TargetPlatform.iOS : TargetPlatform.android;

  /// bool to check whether the user is already login the application
  static bool isUserLoggedIn = false;

  /// Username of logged in user
  static String logInUsername = "";
}
