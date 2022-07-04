import 'package:flutter_test/flutter_test.dart';
import 'package:food_deliver/screen/bottom_navigation/model/product_model.dart';

void main() {
  test("add ons product", () {
    Map<String, dynamic> products = {};

    void addOnsProduct(ProductModel product) {
      int id = product.id!;
      bool isHave = products.keys.contains(product.id.toString());
      if (!isHave) {
        products.addAll(
          {id.toString(): 1},
        );
      } else {
        products.entries.fold(
          null,
          (previousValue, element) => element.key == id.toString()
              ? (element.value as List).add(product.toJson())
              : null,
        );
      }
    }

    addOnsProduct(
      ProductModel(
        id: 3,
        image: "png_healthy_food_plate",
        price: 40,
        title: "Healthy Food Plate",
      ),
    );

    expect(products, {
      3: [
        ProductModel(
          id: 3,
          image: "png_healthy_food_plate",
          price: 40,
          title: "Healthy Food Plate",
        ),
      ]
    });
  });
}
/*
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
    
    
    */