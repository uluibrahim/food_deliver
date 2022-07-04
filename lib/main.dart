import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_deliver/core/constants/app/app_constants.dart';
import 'package:food_deliver/locator.dart';
import 'package:food_deliver/screen/splash/splash_view.dart';
import 'package:food_deliver/user_data.dart';
import 'package:provider/provider.dart';

import 'core/init/theme/ligth/app_theme_light.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  setupLocator();
  runApp(
    EasyLocalization(
      supportedLocales: ApplicationConstants.supportedLocale,
      path: ApplicationConstants.langAssetsPath,
      fallbackLocale: ApplicationConstants.enLocale,
      startLocale: ApplicationConstants.enLocale,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => UserData(),
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: ApplicationConstants.appName,
        theme: AppThemeLight.instance.theme,
        home: const SplashScreen(),
      ),
    );
  }
}
