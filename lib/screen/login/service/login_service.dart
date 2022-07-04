import 'package:food_deliver/screen/login/model/user_model.dart';

import 'i_login_service.dart';

class LoginService extends ILoginService {
  @override
  login({required String email, required String password}) {
    return User(
      id: 1,
      email: "ibrahimhalillulu@gmail.com",
      name: "İbrahim Halil",
      surname: "ULU",
      token: "AJLK326O670P098.HJBD907.GJNOE564",
      profileImage: "https://picsum.photos/200/300",
    );
  }
}
