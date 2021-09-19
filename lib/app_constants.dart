import 'package:flutter/material.dart';

abstract class AppConstants {
  static const List<String> _supportedLanguages = ['en', 'ja'];
  static const List<Locale> _supportedLocales = [
    Locale('en', ''),
    Locale('ja', '')
  ];

  static List<String> get supportedLanguages => _supportedLanguages;
  static List<Locale> get supportedLocales => _supportedLocales;
}
