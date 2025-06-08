import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:greennovo/models/order_item_model.dart';
import 'package:greennovo/models/product_model.dart';
import 'package:greennovo/models/user_model.dart';
import 'package:greennovo/models/order_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('greengrocer.db');
    return _database!;
  }

  Future<Database> _initDB(String path) async {
    final dbPath = await getDatabasesPath();
    final dbLocation = join(dbPath, path);
    return await openDatabase(dbLocation, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // Criação das tabelas
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        type TEXT CHECK(type IN ('client', 'supplier')),
        address TEXT,
        phone TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE products (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        category TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE orders (
        id TEXT PRIMARY KEY,
        date INTEGER NOT NULL,
        total REAL NOT NULL,
        status TEXT NOT NULL,
        customer_id TEXT,
        notes TEXT,
        payment_method TEXT,
        FOREIGN KEY(customer_id) REFERENCES users(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE order_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        order_id TEXT,
        product_id TEXT,
        quantity INTEGER NOT NULL,
        price REAL NOT NULL,
        FOREIGN KEY(order_id) REFERENCES orders(id),
        FOREIGN KEY(product_id) REFERENCES products(id)
      )
    ''');
  }

  // Função para adicionar um usuário (cliente ou fornecedor)
  Future<int> addUser(User user) async {
    final db = await instance.database;
    return await db.insert('users', user.toMap());
  }

  // Função para adicionar um produto
  Future<int> addProduct(Product product) async {
    final db = await instance.database;
    return await db.insert('products', product.toMap());
  }

  // Função para adicionar um pedido
  Future<int> addOrder(Order order) async {
    final db = await instance.database;
    return await db.insert('orders', order.toMap());
  }

  // Função para adicionar um item ao pedido
  Future<int> addOrderItem(OrderItem orderItem) async {
    final db = await instance.database;
    return await db.insert('order_items', orderItem.toMap());
  }

  // Função para recuperar todos os pedidos de um cliente
  Future<List<Order>> fetchOrdersByCustomer(String customerId) async {
    final db = await instance.database;
    final result = await db.query(
      'orders',
      where: 'customer_id = ?',
      whereArgs: [customerId],
    );

    return result.map((e) => Order.fromMap(e)).toList();
  }
}