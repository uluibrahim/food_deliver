import 'package:flutter/material.dart';
import 'package:food_deliver/core/extension/context_extensions.dart';
import 'package:food_deliver/screen/bottom_navigation/viewmodel/bottom_navigation_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../core/constants/enums/tab_item_enum.dart';

mixin TabItemsData {
  Tab getTab(TabItems tabItems, int index, BuildContext context) {
    switch (tabItems) {
      case TabItems.home:
        return Tab(
          icon: index == tabItems.index
              ? const Icon(Icons.home)
              : const Icon(Icons.home_outlined),
        );
      case TabItems.search:
        return Tab(
          icon: index == tabItems.index
              ? const Icon(Icons.search)
              : const Icon(Icons.search_outlined),
        );
      case TabItems.basket:
        return Tab(
            icon: context
                    .watch<BottomNavigationViewmodel>()
                    .basketProducts
                    .isNotEmpty
                ? _basketNotEmptyCircle(index, tabItems, context)
                : index == tabItems.index
                    ? const Icon(Icons.shopping_cart_rounded)
                    : const Icon(Icons.shopping_cart_outlined));
      case TabItems.profil:
        return Tab(
          icon: index == tabItems.index
              ? const Icon(Icons.person)
              : const Icon(Icons.person_outline),
        );
    }
  }
}

Stack _basketNotEmptyCircle(
    int index, TabItems tabItems, BuildContext context) {
  return Stack(
    alignment: Alignment.topRight,
    children: [
      Container(
          margin: const EdgeInsets.only(top: 15, right: 10),
          child: index == tabItems.index
              ? const Icon(Icons.shopping_cart_rounded)
              : const Icon(Icons.shopping_cart_outlined)),
      Container(
        height: 17,
        width: 17,
        decoration: BoxDecoration(
          color: index == tabItems.index
              ? const Color(0xffCC1A74)
              : Colors.grey.shade400,
          shape: BoxShape.circle,
        ),
        child: index == tabItems.index
            ? Center(
                child: Text(
                  context
                      .watch<BottomNavigationViewmodel>()
                      .basketProducts
                      .length
                      .toString(),
                  style: context.textTheme.titleSmall
                      ?.copyWith(color: Colors.white, fontSize: 10),
                ),
              )
            : null,
      )
    ],
  );
}
