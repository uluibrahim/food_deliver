import 'package:flutter/material.dart';
import 'package:food_deliver/core/constants/image/image_constatns.dart';
import 'package:food_deliver/screen/home/model/category_model.dart';

import '../../bottom_navigation/model/product_model.dart';

class HomeViewmodel with ChangeNotifier {
  HomeViewmodel() {
    getCategory();
    getProducts();
  }
  int _selectedCategory = 0;
  int get selectedCategory => _selectedCategory;
  set selectedCategory(int selectedCategory) {
    _selectedCategory = selectedCategory;
    notifyListeners();
  }

  List<CategoryModel>? _categoryModelList;
  Map<int, CategoryModel>? categorys;

  void getCategory() {
    _categoryModelList = [
      CategoryModel(
          title: "All", image: ImageConstants.instance.toPng("png_board_food")),
      CategoryModel(
          title: "Burger",
          image: ImageConstants.instance.toPng("png_burger_sandwich")),
      CategoryModel(
          title: "Pizza", image: ImageConstants.instance.toPng("png_pizza")),
      CategoryModel(
          title: "Dessert",
          image: ImageConstants.instance.toPng("png_dessert")),
    ];
    categorys = _categoryModelList?.asMap();
  }

  List<ProductModel>? productList;

  void getProducts() {
    productList = [
      ProductModel(
        id: 1,
        title: "Bison Burgers",
        image: "png_burger_sandwich",
        price: 34,
        bigImage: "png_burger_sandwich_xl",
      ),
      ProductModel(
        id: 2,
        title: "Gelato",
        image: "png_dessert",
        price: 65,
        bigImage: null,
      ),
    ];
  }
}
