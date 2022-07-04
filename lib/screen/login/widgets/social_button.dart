import 'package:flutter/material.dart';
import 'package:food_deliver/core/constants/image/image_constatns.dart';
import 'package:food_deliver/core/extension/context_extensions.dart';

class SocialButton extends ElevatedButton {
  final BuildContext context;
  final void Function()? onPress;
  final String imagePath;
  SocialButton(
      {Key? key, required this.context, this.onPress, required this.imagePath})
      : super(
          key: key,
          style: ButtonStyle(
            maximumSize:
                MaterialStateProperty.all(Size(context.width * 0.2, 45)),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
          ),
          onPressed: onPress,
          child: Center(
            child: Image.asset(ImageConstants.instance.toPng(imagePath),fit: BoxFit.scaleDown,),
          ),
        );
}
