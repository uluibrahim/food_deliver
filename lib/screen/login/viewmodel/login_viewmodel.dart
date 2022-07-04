import 'package:flutter/material.dart';
import 'package:food_deliver/locator.dart';
import 'package:food_deliver/product/enums/view_state_enum.dart';
import 'package:food_deliver/screen/login/model/user_model.dart';
import 'package:food_deliver/screen/login/service/login_service.dart';

class LoginViewmodel extends LoginService with ChangeNotifier {
  final _service = locator<LoginService>();

  ViewStateEnum _state = ViewStateEnum.idle;
  ViewStateEnum get state => _state;
  set state(ViewStateEnum state) {
    _state = state;
    notifyListeners();
  }

  bool _obscure = true;
  bool get obscure => _obscure;
  set obscure(bool obscure) {
    _obscure = obscure;
    notifyListeners();
  }

  AutovalidateMode _validateMode = AutovalidateMode.disabled;
  AutovalidateMode get validateMode => _validateMode;
  changeValidateMode() {
    _validateMode = AutovalidateMode.always;
    notifyListeners();
  }

  User? user;

  @override
  bool login({required String email, required String password}) {
    state = ViewStateEnum.idle;
    try {
      user = _service.login(email: email, password: password);
      return true;
    } catch (e) {
      return false;
    } finally {
      state = ViewStateEnum.idle;
    }
  }
}
