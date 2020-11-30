import 'package:flutter/cupertino.dart';
import 'package:spot_promo_test/base/models/user_model.dart';
import 'package:spot_promo_test/base/services/user_services.dart';

class UserController {
  static createUser(
      {@required String name,
      @required String dateOfBirth,
      @required String userName,
      @required String pass}) async {
    try {
      User user = User();
      user.name = name;
      user.dateOfBirth = dateOfBirth;
      user.userName = userName;
      user.pass = pass;
      var serviceReturn = await UserServices.createUser(user);
      return serviceReturn;
    } catch (e) {
      var response = [false, "Aconteceu um problema inesperado, tente novamente"];
      return response;
    }
  }
  static login(
      { @required String userName,
      @required String pass}) async {
    try {
      User user = User();
      user.userName = userName;
      user.pass = pass;
      var serviceReturn = await UserServices.loginUser(user);
      return serviceReturn;
    } catch (e) {
      var response = [false, "Aconteceu um problema inesperado, tente novamente"];
      return response;
    }
  }

}
