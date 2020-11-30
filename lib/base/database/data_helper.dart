import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataHelper {
  //--------------bloc table
  static final String tbProducts = "tbProducts";

  static final String tbCodSku = "tbCodSku";
  static final String tbCodBu = "tbCodBu";
  static final String tbDesBu = "tbDesBu";
  static final String tbCodSubBu = "tbCodSubBu";
  static final String tbDesSubBu = "tbDesSubBu";
  static final String tbCodMarca = "tbCodMarca";
  static final String tbDesMarca = "tbDesMarca";
  static final String tbCodCategoria = "tbCodCategoria";
  static final String tbDesCategoria = "tbDesCategoria";
  static final String tbCodSubCategoria = "tbCodSubCategoria";
  static final String tbDesSubCategoria = "tbDesSubCategoria";
  static final String tbDesSku = "tbDesSku";
  static final String tbPrecoSugerido = "tbPrecoSugerido";
  static final String tbFlConcorrente = "tbFlConcorrente";
  static final String tbUrlProduto = "tbUrlProduto";
  //--------------bloc table

  static final DataHelper _instance = DataHelper.internal();

  factory DataHelper() => _instance;

  DataHelper.internal();

  Database _db;

  deleteDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "spot_promo.db");
    deleteDatabase(path);
  }

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "spot_promo.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newVersion) async {
      await db.execute(""
          "CREATE TABLE IF NOT EXISTS $tbProducts($tbCodSku INTEGER, $tbCodBu INTEGER,$tbDesBu TEXT,$tbCodSubBu INTEGER, $tbDesSubBu TEXT,$tbCodMarca INTEGER, $tbDesMarca TEXT, $tbCodCategoria INTEGER, $tbDesCategoria TEXT, $tbCodSubCategoria INTEGER, $tbDesSubCategoria TEXT, $tbDesSku TEXT, $tbPrecoSugerido REAL, $tbFlConcorrente TEXT, $tbUrlProduto TEXT); ");
    });
  }
}
