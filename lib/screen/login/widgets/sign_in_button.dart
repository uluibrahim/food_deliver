import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_deliver/core/extension/context_extensions.dart';
import 'package:food_deliver/core/init/language/locale_keys.dart';

import '../../../product/default_size.dart';

class SignInButton extends ElevatedButton {
  final BuildContext context;
  final void Function()? onPress;
  SignInButton({Key? key, required this.context, this.onPress})
      : super(
          key: key,
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
              Size(
                  context.width * (0.70), DefaultSize.instance.defaultHeight50),
            ),
            backgroundColor: MaterialStateProperty.all(const Color(0xff927583)),
            shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
          ),
          onPressed: onPress,
          child: Text(
            LocaleKeys.signIn.tr(),
            style: context.textTheme.headline6
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        );
}
