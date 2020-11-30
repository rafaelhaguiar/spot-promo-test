import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spot_promo_test/base/models/user_model.dart';
import 'package:spot_promo_test/products/services/products_services.dart';

class UserServices {
  static Future<dynamic> createUser(User user) async {
    try {
      String url = 'https://s3.spotpromo.com.br/test-api/funcionario';
      var json = user.toJson();
      var response = await http
          .post(url, body: json, headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        var returnLogin = await loginUser(user);
        return returnLogin;
      }
      if (response.statusCode == 300) {
        return;
      }
    } catch (e) {
      print(e);
      return;
    }
  }

  static Future<dynamic> loginUser(User user) async {
    var returnArray;
    try {
      String url = 'https://s3.spotpromo.com.br/test-api/login';
      var response = await http.post(url,
          body: user.userToJson(),
          headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (!data['error']) {
          var sharedPreference = await SharedPreferences.getInstance();
          sharedPreference.setString("token", data['token']);
          var aux = await ProductsServices.getProducts();
          print(aux);
          returnArray = [true, 'Success'];
          return returnArray;
        } else {
          returnArray = [false, 'Usuário ou senha incorreto, tente novamente'];

          return returnArray;
        }
      }

      return "Aconteceu algum problema, tente novamente";
    } catch (e) {
      var returnArray = [false, 'Usuário ou senha incorreto, tente novamente'];
      return returnArray;
    }
  }
}
