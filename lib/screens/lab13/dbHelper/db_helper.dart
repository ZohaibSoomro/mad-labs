import 'dart:async';

import 'package:lab2_task/screens/lab13/model/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper instance = DbHelper._init();
  DbHelper._init();
  Database? _database;
  static String dbName = "Mydb.db";
  static String tableName = "Products";
  Future<Database> get database async => _database ??= await openDatabase(
        join(await getDatabasesPath(), dbName),
        onCreate: onCreate,
        version: 1,
      );

  Future<void> onCreate(Database db, int version) async {
    final result = await db.execute(
        "CREATE TABLE $tableName(name Text, type Text, family TEXT ,unit INTEGER)");
    print("Table $tableName created");
  }

  Future<void> insertProduct(Product product) async {
    final db = await instance.database;
    var result = await db.insert(tableName, product.toJSON());
    print("data inserted ${result}");
  }

  Future<void> deleteProduct(String name) async {
    final db = await instance.database;
    var result = await db.delete(
      tableName,
      where: 'name=?',
      whereArgs: [name],
    );
    print("data deleted ${result}");
  }

  Future<List<Product>> getAllProducts() async {
    List<Product> products = [];
    final db = await instance.database;
    final result = await db.query(tableName);
    for (final data in result) {
      final product = Product.fromJSON(data);
      products.add(product);
    }
    return products;
  }
}
