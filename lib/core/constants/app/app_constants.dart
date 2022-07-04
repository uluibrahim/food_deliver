import 'package:flutter/material.dart';

class ApplicationConstants {
  static const langAssetsPath = 'assets/language';
  static const appName = 'Food Delivery';
  static const lottieSplash = '';

  static const trLocale = Locale("tr", "TR");
  static const enLocale = Locale("en", "US");

  static const supportedLocale = [
    ApplicationConstants.trLocale,
    ApplicationConstants.enLocale,
  ];
}
