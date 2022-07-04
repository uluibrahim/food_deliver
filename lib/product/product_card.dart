import 'package:flutter/material.dart';
import 'package:food_deliver/core/extension/context_extensions.dart';

import '../core/constants/image/image_constatns.dart';

class ProductCard extends Container {
  final BuildContext context;
  final String? imagePath;
  final double? widthRatio;
  final double? heightRatio;
  ProductCard({
    Key? key,
    required this.context,
    required this.imagePath,
    this.heightRatio = 0.25,
    this.widthRatio = 0.23,
  }) : super(
          key: key,
          margin: const EdgeInsets.all(7),
          width: context.width * widthRatio!,
          height: context.width * heightRatio!,
          decoration: const BoxDecoration(
            color: Color(0xffD9C9C9),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: imagePath != null
              ? Image.asset(ImageConstants.instance.toPng(imagePath))
              : null,
        );
}
