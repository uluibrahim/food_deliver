import 'package:flutter/material.dart';
import 'package:food_deliver/core/extension/context_extensions.dart';
import 'package:food_deliver/product/default_size.dart';

class CustomElevatedButton extends ElevatedButton {
  final BuildContext context;
  final void Function()? onPress;
  final String textButton;
  final Color? buttonColor;
  final TextStyle? textStyle;
  final double? widthRatio;
  CustomElevatedButton({
    Key? key,
    required this.onPress,
    required this.context,
    required this.textButton,
    this.buttonColor = Colors.white,
    this.textStyle,
    this.widthRatio,
  }) : super(
          key: key,
          onPressed: onPress,
          style: _buttonStyle(context, widthRatio, buttonColor),
          child: _buttonText(textButton, textStyle, context),
        );
}

ButtonStyle _buttonStyle(
    BuildContext context, double? widthRatio, Color? buttonColor) {
  return ButtonStyle(
    minimumSize: MaterialStateProperty.all(
      Size(
        context.width * (widthRatio ?? 0.50),
        DefaultSize.instance.defaultHeight50,
      ),
    ),
    backgroundColor: MaterialStateProperty.all(buttonColor),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(DefaultSize.instance.defaultHeight50 / 2),
        ),
      ),
    ),
  );
}

Text _buttonText(
    String textButton, TextStyle? textStyle, BuildContext context) {
  return Text(
    textButton,
    style: textStyle ??
        context.textTheme.button?.copyWith(
            color: const Color(0xff644AB5), fontWeight: FontWeight.bold),
  );
}
