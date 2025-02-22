import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  static Future<Database> initDb() async {
    return sql.openDatabase(
      'products.db', // Database name
      version: 1, // Version number
      onCreate: (Database database, int version) async {
        await createTable(database);
      },
    );
  }

  static Future<void> createTable(Database database) async {
    await database.execute("""
      CREATE TABLE products(
        id TEXT PRIMARY KEY NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        image TEXT,
        quantity INTEGER NOT NULL,
        price REAL NOT NULL
      )
    """);
    debugPrint("Table Created");
  }

  // Add a product
  static Future<int> add(String productId, String name, String description, String imageUrl, int quantity, double price) async {
    final db = await SQLHelper.initDb();
    final data = {
      'id': productId,
      'title': name,
      'description': description,
      'image': imageUrl,
      'quantity': quantity,
      'price': price
    };
    final id = await db.insert('products', data, conflictAlgorithm: ConflictAlgorithm.replace);
    debugPrint("Product Added");
    return id;
  }

  // Read all products
  static Future<List<Map<String, dynamic>>> get() async {
    final db = await SQLHelper.initDb();
    return db.query('products', orderBy: "id");
  }

  // Get product by productId
  static Future<List<Map<String, dynamic>>> getByProductId(String productId) async {
    final db = await SQLHelper.initDb();
    return db.query('products', where: "id = ?", whereArgs: [productId]);
  }

  // Update product
  static Future<int> update(String productId, String name, String description, String imageUrl, int quantity, double price) async {
    final db = await SQLHelper.initDb();
    final data = {
      'title': name,
      'description': description,
      'image': imageUrl,
      'quantity': quantity,
      'price': price
    };
    final result = await db.update('products', data, where: "id = ?", whereArgs: [productId]);
    return result;
  }

  // Delete product
  static Future<void> delete(String productId) async {
    final db = await SQLHelper.initDb();
    try {
      await db.delete("products", where: "id = ?", whereArgs: [productId]);
    } catch (err) {
      debugPrint("Something went wrong: $err");
    }
  }
}