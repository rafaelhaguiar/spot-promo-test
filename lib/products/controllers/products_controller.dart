import 'package:spot_promo_test/products/models/products_model.dart';

class ProductsController {
  static Future<List<ProductsModel>> fetchProducts() async {
    var products = await ProductsModel.getProducts();
    return products;
  }
}
