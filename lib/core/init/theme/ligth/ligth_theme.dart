import 'package:food_deliver/core/init/theme/ligth/color_schema_ligth.dart';
import 'package:food_deliver/core/init/theme/ligth/text_theme_ligth.dart';

abstract class ILightTheme {
  TextThemeLight? get textThemeLight => TextThemeLight.instance;
  ColorSchemeLight? get colorSchemeLight => ColorSchemeLight.instance;
}
