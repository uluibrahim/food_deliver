import 'package:flutter/material.dart';

import '../../bottom_navigation/model/product_model.dart';

class ProductDetailViewmodel extends ChangeNotifier {
  ProductModel baseProduct;
  ProductDetailViewmodel(this.baseProduct) {
    addedProductsCount = 1;
    addProduct(baseProduct);
  }

  late int addedProductsCount;

  void addBaseProduct() {
    addedProductsCount += 1;
    addProduct(baseProduct);
    notifyListeners();
  }

  void removeBaseProduct() {
    if (addedProductsCount != 0) {
      addedProductsCount -= 1;
      if (addedProductsCount == 0) {
        products.remove(baseProduct.id.toString());
      } else {
        products.entries.fold(null, (previousValue, element) {
          if (element.key == baseProduct.id.toString()) {
            return element.value.add(baseProduct);
          }
        });
      }
      notifyListeners();
    }
  }

  final List<ProductModel> addsOnsProducts = [
    ProductModel(
      id: 3,
      image: "png_healthy_food_plate",
      price: 40,
      title: "Healthy Food Plate",
    ),
    ProductModel(
      id: 4,
      image: "png_cheese_pizza",
      price: 25,
      title: "Pizza",
    ),
    ProductModel(
      id: 5,
      image: "png_food_dessert",
      price: 65,
      title: "Dessert",
    ),
  ];

  void addProduct(ProductModel product) {
    int id = product.id!;
    bool isHave = products.keys.contains(product.id.toString());
    if (!isHave) {
      products.addAll({
        id.toString(): [product]
      });
    } else {
      products.entries.fold(null, (previousValue, element) {
        if (element.key == id.toString()) {
          return element.value.add(product);
        }
      });
    }
  }

  Map<String, List<ProductModel>> products = {};
}
