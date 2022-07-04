import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_deliver/core/constants/image/image_constatns.dart';
import 'package:food_deliver/core/extension/context_extensions.dart';
import 'package:food_deliver/core/navigator/navigator_manager.dart';
import 'package:food_deliver/screen/login/view/login_view.dart';
import 'package:food_deliver/screen/login/viewmodel/login_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../core/component/button/custom_elevated_button.dart';
import '../../../core/init/language/locale_keys.dart';

class OnBoardView extends StatelessWidget with NavigatorManager {
  const OnBoardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _decoration,
        child: Column(
          children: [
            Expanded(flex: 60, child: _boardFoodCircle(context)),
            Expanded(flex: 12, child: _boardText(context)),
            _getStartedButton(context),
          ],
        ),
      ),
    );
  }

  SizedBox _getStartedButton(BuildContext context) {
    return SizedBox(
      height: context.height * 0.2,
      child: Center(
        child: CustomElevatedButton(
          context: context,
          textButton: LocaleKeys.getStarted.tr(),
          onPress: () {
            navigateReplaceToWidget(
              context,
              ChangeNotifierProvider(
                create: (_) => LoginViewmodel(),
                child: const LoginView(),
              ),
            );
          },
        ),
      ),
    );
  }

  RichText _boardText(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Your everyday ",
            style: _customTextStyle(true, context),
          ),
          TextSpan(
            text: " meal\n",
            style: _customTextStyle(false, context),
          ),
          TextSpan(
            text: "\ndelivered ",
            style: _customTextStyle(true, context),
          ),
          TextSpan(
            text: " to you",
            style: _customTextStyle(false, context),
          ),
        ],
      ),
    );
  }

  Center _boardFoodCircle(BuildContext context) {
    return Center(
      child: CircleAvatar(
        backgroundColor: context.theme.colorScheme.onBackground,
        radius: context.height * 0.17,
        child: Image.asset(ImageConstants.instance.toPng("png_board_food")),
      ),
    );
  }

  BoxDecoration get _decoration {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xffD11770),
          Color(0xff6A47B1),
        ],
      ),
    );
  }

  TextStyle? _customTextStyle(bool isWhite, BuildContext context) {
    return context.textTheme.headline4
        ?.copyWith(color: isWhite ? Colors.white : const Color(0xff761616));
  }
}
