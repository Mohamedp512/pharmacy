import 'package:path/path.dart';
import 'package:safwat_pharmacy/core/view_model/cart_view_model.dart';
import 'package:safwat_pharmacy/costants.dart';
import 'package:safwat_pharmacy/models/cart_item_model.dart';
import 'package:sqflite/sqflite.dart';

class CartDatabaseHelper {
  CartDatabaseHelper._();
  static final CartDatabaseHelper db = CartDatabaseHelper._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDb();
    return _database;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'CartProduct.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE $tableCartProduct(
        $columnName TEXT NOT NULL, 
        $columnImage TEXT NOT NULL,
        $columnQuantity INTEGER NOT NULL,
        $columnPrice REAL NOT NULL,
        $columnproductId TEXT NOT NULL,
        $columnRating INTEGER NOT NULL
      )''');
    });
  }

  insert(CartItemModel cartItem) async {
    var dbClient = await database;
    await dbClient.insert(
      tableCartProduct,
      cartItem.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  updateCartItem(CartItemModel cartItem) async {
    var dbClient = await database;
    return await dbClient.update(tableCartProduct, cartItem.toJson(),
        where: '$columnproductId=?', whereArgs: [cartItem.productId]);
  }

  deleteCartItem(CartItemModel cartItem) async {
    var dbClient = await database;
    return await dbClient.delete(tableCartProduct,
        where: '$columnproductId=?', whereArgs: [cartItem.productId]);
  }

  Future<List<CartItemModel>> getAllCartItems() async {
    var dbClient = await database;
    List<Map> map = await dbClient.query(tableCartProduct);
    List<CartItemModel> cartItems = map.isNotEmpty
        ? map.map((cartItem) => CartItemModel.fromJson(cartItem)).toList()
        : [];
    return cartItems;
  }

  deleteCartDatabase()async{
    await _database.delete(tableCartProduct);
  }
}
