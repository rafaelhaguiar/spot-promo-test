import 'package:spot_promo_test/base/database/data_helper.dart';

class ProductsModel {
  int codSku;
  int codBu;
  String desBu;
  int codSubBu;
  String desSubBu;
  int codMarca;
  String desMarca;
  int codCategoria;
  String desCategoria;
  int codSubCategoria;
  String desSubCategoria;
  String desSku;
  double precoSugerido;
  String flConcorrente;
  String urlProduto;
  ProductsModel({
    this.codSku,
    this.codBu,
    this.desBu,
    this.codSubBu,
    this.desSubBu,
    this.codMarca,
    this.desMarca,
    this.codCategoria,
    this.desCategoria,
    this.codSubCategoria,
    this.desSubCategoria,
    this.desSku,
    this.precoSugerido,
    this.flConcorrente,
    this.urlProduto,
  });

  static getProducts() async {
    try {
      String tbProducts = DataHelper.tbProducts;
      DataHelper helper = DataHelper();
      var db = await helper.db;
      List listMap = await db.rawQuery("select * from $tbProducts");
      List<ProductsModel> products = List();
      for (Map map in listMap) {
        products.add(ProductsModel.fromMap(map));
      }
      return products;
    } catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> toMap() {
    return {
      DataHelper.tbCodSku: codSku,
      DataHelper.tbCodBu: codBu,
      DataHelper.tbDesBu: desBu,
      DataHelper.tbCodSubBu: codSubBu,
      DataHelper.tbDesSubBu: desSubBu,
      DataHelper.tbCodMarca: codMarca,
      DataHelper.tbDesMarca: desMarca,
      DataHelper.tbCodCategoria: codCategoria,
      DataHelper.tbDesCategoria: desCategoria,
      DataHelper.tbCodSubCategoria: codSubCategoria,
      DataHelper.tbDesSubCategoria: desSubCategoria,
      DataHelper.tbDesSku: desSku,
      DataHelper.tbPrecoSugerido: precoSugerido,
      DataHelper.tbFlConcorrente: flConcorrente,
      DataHelper.tbUrlProduto: urlProduto,
    };
  }

  ProductsModel.fromMap(Map map) {
    codSku = map[DataHelper.tbCodSku];
    codBu = map[DataHelper.tbCodBu];
    desBu = map[DataHelper.tbDesBu];
    codSubBu = map[DataHelper.tbCodSubBu];
    desSubBu = map[DataHelper.tbDesSubBu];
    codMarca = map[DataHelper.tbCodMarca];
    desMarca = map[DataHelper.tbDesMarca];
    codCategoria = map[DataHelper.tbCodCategoria];
    desCategoria = map[DataHelper.tbDesCategoria];
    codSubCategoria = map[DataHelper.tbCodSubCategoria];
    desSubCategoria = map[DataHelper.tbDesSubCategoria];
    desSku = map[DataHelper.tbDesSku];
    precoSugerido = map[DataHelper.tbPrecoSugerido];
    flConcorrente = map[DataHelper.tbFlConcorrente];
    urlProduto = map[DataHelper.tbUrlProduto];
  }

  ProductsModel.fromJson(Map<String, dynamic> json) {
    codSku = json['codSku'];
    codBu = json['codBu'];
    desBu = json['desBu'];
    codSubBu = json['codSubBu'];
    desSubBu = json['desSubBu'];
    codMarca = json['codMarca'];
    desMarca = json['desMarca'];
    codCategoria = json['codCategoria'];
    desCategoria = json['desCategoria'];
    codSubCategoria = json['codSubCategoria'];
    desSubCategoria = json['desSubCategoria'];
    desSku = json['desSku'];
    precoSugerido = json['precoSugerido'];
    flConcorrente = json['flConcorrente'];
    urlProduto = json['urlProduto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codSku'] = this.codSku;
    data['codBu'] = this.codBu;
    data['desBu'] = this.desBu;
    data['codSubBu'] = this.codSubBu;
    data['desSubBu'] = this.desSubBu;
    data['codMarca'] = this.codMarca;
    data['desMarca'] = this.desMarca;
    data['codCategoria'] = this.codCategoria;
    data['desCategoria'] = this.desCategoria;
    data['codSubCategoria'] = this.codSubCategoria;
    data['desSubCategoria'] = this.desSubCategoria;
    data['desSku'] = this.desSku;
    data['precoSugerido'] = this.precoSugerido;
    data['flConcorrente'] = this.flConcorrente;
    data['urlProduto'] = this.urlProduto;
    return data;
  }

  static saveProducts(ProductsModel product) async {
    try {
      DataHelper helper = DataHelper();
      var db = await helper.db;
      db.insert(DataHelper.tbProducts, product.toMap());
    } catch (e) {
      print(e);
    }
  }

  @override
  String toString() {
    return 'ProductsModel(codSku: $codSku, codBu: $codBu, desBu: $desBu, codSubBu: $codSubBu, desSubBu: $desSubBu, codMarca: $codMarca, desMarca: $desMarca, codCategoria: $codCategoria, desCategoria: $desCategoria, codSubCategoria: $codSubCategoria, desSubCategoria: $desSubCategoria, desSku: $desSku, precoSugerido: $precoSugerido, flConcorrente: $flConcorrente, urlProduto: $urlProduto)';
  }
}
