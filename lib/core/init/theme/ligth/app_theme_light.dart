import 'package:flutter/material.dart';
import 'package:food_deliver/core/init/theme/ligth/ligth_theme.dart';
import 'package:food_deliver/core/init/theme/app_theme.dart';

class AppThemeLight extends AppTheme with ILightTheme {
  static AppThemeLight? _instance;
  static AppThemeLight get instance => _instance ??= AppThemeLight._init();

  AppThemeLight._init();
  @override
  ThemeData get theme => ThemeData.light().copyWith(
      colorScheme: _appColorScheme,
      textTheme: _textTheme,
      appBarTheme: appBarTheme,
      tabBarTheme: tabBarTheme);

  TextTheme get _textTheme => ThemeData.light().textTheme.copyWith();

  ColorScheme get _appColorScheme =>
      ThemeData.light().colorScheme.copyWith(brightness: Brightness.light);

  AppBarTheme get appBarTheme => ThemeData.light().appBarTheme.copyWith(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      );

  TabBarTheme get tabBarTheme => ThemeData.light().tabBarTheme.copyWith(
        labelColor: const Color(0xffCE1973),
        labelPadding: const EdgeInsets.all(15),
        unselectedLabelColor: Colors.black38,
      );
}
