import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spot_promo_test/base/database/data_helper.dart';
import 'package:spot_promo_test/products/models/products_model.dart';

class ProductsServices {
  static getProducts() async {
    var sharedPreference = await SharedPreferences.getInstance();
    var token = sharedPreference.getString('token');
    String url = 'https://s3.spotpromo.com.br/test-api/produtos';
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      List listResponse = json.decode(response.body);
      DataHelper helper = DataHelper();
      helper.deleteDb();

      for (var product in listResponse) {
        ProductsModel p = ProductsModel();
        p.codSku = int.parse(product['codSku']);
        p.codBu = int.parse(product['codBu']);
        p.desBu = product['desBu'];
        p.codSubBu = int.parse(product['codSubBu']);
        p.desSubBu = product['desSubBu'];
        p.codMarca = int.parse(product['codMarca']);
        p.desMarca = product['desMarca'];
        p.codCategoria = int.parse(product['codCategoria']);
        p.desCategoria = product['desCategoria'];
        p.codSubCategoria = int.parse(product['codSubCategoria']);
        p.desSubCategoria = product['desSubCategoria'];
        p.desSku = product['desSku'];
        p.precoSugerido = double.parse(product['precoSugerido']);
        p.flConcorrente = product['flConcorrente'];
        p.urlProduto = product['urlProduto'];

        ProductsModel.saveProducts(p);
      }
    }
  }
}
