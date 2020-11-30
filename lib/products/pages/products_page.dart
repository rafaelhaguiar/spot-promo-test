import 'package:flutter/material.dart';
import 'package:spot_promo_test/products/controllers/products_controller.dart';
import 'package:spot_promo_test/products/models/products_model.dart';
import 'package:spot_promo_test/utils/custom_colors.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  Future<List<ProductsModel>> futureProductsList;
  @override
  void initState() {
    futureProductsList = ProductsController.fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.reddishRose,
        title: Text('Produtos'),
      ),
      body: Center(
        child: FutureBuilder<List<ProductsModel>>(
          future: futureProductsList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ProductsModel> products = snapshot.data;
              return _listView(products);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator(
              backgroundColor: CustomColors.reddishRose,
            );
          },
        ),
      ),
    );
  }

  ListView _listView(List<ProductsModel> products) {
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, int index) {
          ProductsModel product = products[index];
          return ListTile(
            title: Text(product.desSku),
            subtitle: Text(product.desCategoria),
          );
        });
  }
}
