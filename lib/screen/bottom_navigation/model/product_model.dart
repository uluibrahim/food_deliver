import 'package:food_deliver/core/base/base_model.dart';

class ProductModel extends BaseModel {
  final int? id;
  final int? price;
  final String? title;
  final String? image;
  final String? bigImage;

  ProductModel(
      {required this.id,
      required this.price,
      required this.title,
      required this.image,
      this.bigImage});

  @override
  formJson(Map<String, dynamic> json) => ProductModel(
      id: json["id"],
      price: json["price"],
      title: json["title"],
      image: json["image"],
      bigImage: json["big_image"]);

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "title": title,
        "image": image,
        "big_image": bigImage,
      };
}
