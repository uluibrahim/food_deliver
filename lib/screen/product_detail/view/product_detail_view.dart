import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_deliver/core/constants/image/image_constatns.dart';
import 'package:food_deliver/core/extension/context_extensions.dart';
import 'package:food_deliver/core/init/language/locale_keys.dart';
import 'package:food_deliver/screen/product_detail/viewmodel/product_detail_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../core/component/button/custom_elevated_button.dart';
import '../../../product/add_and_remove_product.dart';
import '../../../product/price_text.dart';
import '../../../product/product_card.dart';
import '../../bottom_navigation/model/product_model.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({Key? key, required}) : super(key: key);

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _productImageCard,
          _backButton,
          Container(
            height: context.height * 0.54,
            width: context.width,
            padding: context.paddingNormal,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(70)),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: context.paddingNormal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _starAndPriceRow,
                    const SizedBox(height: 20),
                    _productTitleAndCount(),
                    const SizedBox(height: 20),
                    const Text(
                        "Big juicy beef burger with beef, lettuce, tomato, onions and special sauce! "),
                    const SizedBox(height: 20),
                    Text(LocaleKeys.addOns.tr(),
                        style: context.textTheme.subtitle1),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: context
                          .read<ProductDetailViewmodel>()
                          .addsOnsProducts
                          .map((e) => Flexible(child: _addOnsCard(e)))
                          .toList(),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: CustomElevatedButton(
                        textStyle: context.textTheme.titleLarge
                            ?.copyWith(color: Colors.white),
                        buttonColor: const Color(0xffCC1A74),
                        onPress: () {
                          Navigator.pop(context,
                              context.read<ProductDetailViewmodel>().products);
                        },
                        textButton: LocaleKeys.addToCart.tr(),
                        context: context,
                        widthRatio: 0.75,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Stack _addOnsCard(ProductModel model) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ProductCard(
          context: context,
          imagePath: model.image,
        ),
        GestureDetector(
          onTap: () {
            context.read<ProductDetailViewmodel>().addProduct(model);
          },
          child: Icon(Icons.add_circle, color: Colors.green.shade700),
        ),
      ],
    );
  }

  Row _productTitleAndCount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.read<ProductDetailViewmodel>().baseProduct.title ?? "",
          style: context.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        AddAndRemoveProduct(
          context: context,
          onTapAdd: () {
            context.read<ProductDetailViewmodel>().addBaseProduct();
          },
          onTapRemove: () {
            context.read<ProductDetailViewmodel>().removeBaseProduct();
          },
          count: context.watch<ProductDetailViewmodel>().addedProductsCount,
        ),
      ],
    );
  }

  Row get _starAndPriceRow {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 50,
          width: 80,
          decoration: const BoxDecoration(
            color: Color(0xffCC1A74),
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Colors.yellow),
              Text(
                " 4.6",
                style:
                    context.textTheme.titleLarge?.copyWith(color: Colors.white),
              )
            ],
          ),
        ),
        PriceText(
          context: context,
          text: context
              .read<ProductDetailViewmodel>()
              .baseProduct
              .price
              .toString(),
        ),
      ],
    );
  }

  Positioned get _backButton {
    return Positioned(
      top: 50,
      left: 12,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
      ),
    );
  }

  Container get _productImageCard {
    return Container(
      height: context.height,
      width: context.width,
      decoration: _decoration,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: context.height * 0.05,
            ),
            SizedBox(
              height: context.height / 3,
              child: Container(
                padding: context.paddingMedium,
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    radius: 0.5,
                    colors: [
                      Colors.white,
                      Color.fromARGB(0, 247, 245, 245),
                    ],
                  ),
                ),
                child: Image.asset(
                  ImageConstants.instance.toPng(
                    context
                            .read<ProductDetailViewmodel>()
                            .baseProduct
                            .bigImage ??
                        context
                            .read<ProductDetailViewmodel>()
                            .baseProduct
                            .image!,
                  ),
                ),
              ),
            ),
          ],
        ),
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
}
