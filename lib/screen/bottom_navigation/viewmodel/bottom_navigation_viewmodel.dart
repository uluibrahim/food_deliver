import 'package:flutter/material.dart';

import '../model/product_model.dart';

class BottomNavigationViewmodel extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set currentIndex(int currentIndex) {
    _currentIndex = currentIndex;
    notifyListeners();
  }

  Map<String, List<ProductModel>> _productsBasketMap = {};
  void getProductsBasketMap(dynamic value) {
    if (value != null && value is Map<String, List<ProductModel>>) {
      _productsBasketMap = value;
      fillList();
    }
  }

  List<MapEntry<String, List<ProductModel>>> basketProducts = [];
  void fillList() {
    for (var element in _productsBasketMap.entries) {
      bool isContain = false;
      int index = 0;
      for (var i = 0; i < basketProducts.length; i++) {
        bool temp = basketProducts[i].key.contains(element.key.toString());
        if (temp) {
          isContain = true;
          index = i;
          break;
        }
      }
      if (isContain) {
        basketProducts[index].value.addAll(element.value);
      } else {
        basketProducts.add(element);
      }
    }
    basketTotalFill();
  }

  void addNewProduct(MapEntry<String, List<ProductModel>> value) {
    for (var i = 0; i < basketProducts.length; i++) {
      bool temp = basketProducts[i].key.contains(value.key.toString());
      if (temp) {
        basketProducts[i].value.add(value.value.first);
        _basketTotal += value.value.first.price ?? 0;
        notifyListeners();
        break;
      }
    }
    notifyListeners();
  }

  void removeProduct(MapEntry<String, List<ProductModel>> value) {
    int price = 0;
    for (var element in value.value) {
      price += element.price ?? 0;
    }
    _basketTotal -= price;
    basketProducts.remove(value);
    notifyListeners();
  }

  void removeOneProduct(MapEntry<String, List<ProductModel>> value) {
    for (var i = 0; i < basketProducts.length; i++) {
      bool temp = basketProducts[i].key.contains(value.key.toString());
      if (temp) {
        if (basketProducts[i].value.length > 1) {
          _basketTotal -= basketProducts[i].value[i].price!;
          basketProducts[i].value.removeAt(i);
        } else {
          removeProduct(value);
        }
        notifyListeners();
        break;
      }
    }
  }

  int _basketTotal = 0;

  int get basketTotal => _basketTotal;

  void basketTotalFill() {
    _basketTotal = 0;
    for (var element in basketProducts) {
      for (var product in element.value) {
        _basketTotal = _basketTotal + product.price!;
      }
    }
    notifyListeners();
  }
}
