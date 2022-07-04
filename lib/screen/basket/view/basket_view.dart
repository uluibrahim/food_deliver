import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_deliver/core/extension/context_extensions.dart';
import 'package:food_deliver/core/init/language/locale_keys.dart';
import 'package:food_deliver/product/product_card.dart';

import '../../../core/component/button/custom_elevated_button.dart';
import '../../../product/add_and_remove_product.dart';
import '../../../product/price_text.dart';
import '../../bottom_navigation/model/product_model.dart';
import '../../bottom_navigation/viewmodel/bottom_navigation_viewmodel.dart';

class BasketView extends StatefulWidget {
  final BottomNavigationViewmodel navigationViewmodel;
  final TabController tabController;
  const BasketView(
      {Key? key,
      required this.navigationViewmodel,
      required this.tabController})
      : super(key: key);

  @override
  State<BasketView> createState() => _BasketViewState();
}

class _BasketViewState extends State<BasketView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: context.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                " ${widget.navigationViewmodel.basketProducts.length.toString()} ${LocaleKeys.itemsInCart.tr()}",
                style: context.textTheme.titleLarge
                    ?.copyWith(color: const Color(0xff463A3A)),
              ),
              const SizedBox(height: 20),
              _basketProductsList,
              Text(
                LocaleKeys.orderInstructions.tr(),
                style: context.textTheme.headline6,
              ),
              const SizedBox(height: 10),
              TextFormField(
                maxLines: 3,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              _basketTotal,
              const SizedBox(height: 10),
              _checkoutButton,
              _backToMenuButton,
            ],
          ),
        ),
      ),
    );
  }

  SizedBox get _basketProductsList {
    return SizedBox(
      height: context.height * 0.35,
      child: SingleChildScrollView(
        child: Column(
          children: widget.navigationViewmodel.basketProducts
              .map((e) => _productCart(e))
              .toList(),
        ),
      ),
    );
  }

  Row get _basketTotal {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(LocaleKeys.total.tr(), style: context.textTheme.titleLarge),
        PriceText(
            text: widget.navigationViewmodel.basketTotal.toString(),
            context: context)
      ],
    );
  }

  Center get _checkoutButton {
    return Center(
      child: CustomElevatedButton(
        textStyle: context.textTheme.titleLarge?.copyWith(color: Colors.white),
        buttonColor: widget.navigationViewmodel.basketTotal > 0
            ? const Color(0xffCC1A74)
            : null,
        onPress: widget.navigationViewmodel.basketTotal > 0 ? () {} : null,
        textButton: LocaleKeys.checkout.tr(),
        context: context,
        widthRatio: 0.75,
      ),
    );
  }

  Center get _backToMenuButton {
    return Center(
      child: TextButton(
        onPressed: () {
          widget.navigationViewmodel.currentIndex = 0;
          widget.tabController.animateTo(0);
        },
        child: Text(
          LocaleKeys.backToMenu.tr(),
          style: context.textTheme.headline5,
        ),
      ),
    );
  }

  Stack _productCart(MapEntry<String, List<ProductModel>> e) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        SizedBox(
          width: context.width,
          height: context.width * 0.35,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductCard(
                context: context,
                imagePath: e.value.first.image,
                heightRatio: 0.35,
                widthRatio: 0.25,
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    e.value.first.title ?? "",
                    style: context.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  PriceText(
                    context: context,
                    text: e.value.first.price.toString(),
                  ),
                  const SizedBox(height: 10),
                  AddAndRemoveProduct(
                    context: context,
                    onTapAdd: () {
                      widget.navigationViewmodel.addNewProduct(e);
                    },
                    onTapRemove: () {
                      widget.navigationViewmodel.removeOneProduct(e);
                    },
                    count: e.value.length,
                  ),
                  const SizedBox(height: 10),
                ],
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            widget.navigationViewmodel.removeProduct(e);
          },
          child: const Icon(Icons.cancel_outlined, color: Colors.red),
        ),
      ],
    );
  }
}
