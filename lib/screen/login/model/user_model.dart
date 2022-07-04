import '../../../core/base/base_model.dart';

class User extends BaseModel {
  final int? id;
  final String? token;
  final String? email;
  String? name;
  String? surname;
  String? profileImage;

  User({
    this.id,
    this.token,
    this.email,
    this.name,
    this.surname,
    this.profileImage,
  });

  @override
  formJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        token: json["token"],
        email: json["email"],
        surname: json['surname'],
        profileImage: json["profile_image"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "token": token,
        "name": name,
        "surname": surname,
        "profile_image": profileImage,
      };

  @override
  String toString() {
    return "id: $id, email: $email, name: $name, token: $token, surname: $surname";
  }
}
