import 'package:my_super_cat_app/databases/app_database.dart';
import 'package:my_super_cat_app/models/cat.dart';
import 'package:sqflite/sqflite.dart';

class CatDao {
  Future<void> insert(Cat cat) async {
    final Database database = await AppDatabase().openDB();
    await database.insert(
      AppDatabase().tableName,
      cat.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> delete(String id) async {
    final Database database = await AppDatabase().openDB();
    await database.delete(
      AppDatabase().tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<FavoriteCats>> fetchAll() async {
    final Database database = await AppDatabase().openDB();
    final List<Map<String, dynamic>> maps = await database.query(
      AppDatabase().tableName,
    );
    return List.generate(
      maps.length,
      (i) => FavoriteCats.fromMap(maps[i]),
    );
  }

  Future<bool> isFavorite(String id) async {
    final Database database = await AppDatabase().openDB();
    final List<Map<String, dynamic>> maps = await database.query(
      AppDatabase().tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty;
  }
}
