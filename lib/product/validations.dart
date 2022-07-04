import 'package:easy_localization/easy_localization.dart';
import 'package:food_deliver/core/extension/string_extension.dart';

import '../core/init/language/locale_keys.dart';

mixin Validations {
  String? validationEmail(String? value) {
    return value!.isValidEmail()
        ? null
        : LocaleKeys.pleaseEnterAValidEmail.tr();
  }

  String? validationPassword(String? value) {
    return value!.isEmpty ? LocaleKeys.passwordCannotBeEmpty.tr() : null;
  }
}
