import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblFavorite = 'favorite';
  final String _restaurantId = 'id';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/favorite.db',
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE $_tblFavorite ($_restaurantId TEXT PRIMARY KEY NOT NULL)');
      },
      version: 1,
    );
    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();

    return _database;
  }

  Future<void> addFavorite(String restoId) async {
    final db = await database;
    await db!.rawInsert(
        'INSERT INTO $_tblFavorite($_restaurantId) VALUES ("$restoId")');
  }

  Future<List<String>> getFavorite() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblFavorite);

    return results.map((e) => e['id'] as String).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _tblFavorite,
      where: '$_restaurantId = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;

    await db!.delete(
      _tblFavorite,
      where: '$_restaurantId = ?',
      whereArgs: [id],
    );
  }
}
