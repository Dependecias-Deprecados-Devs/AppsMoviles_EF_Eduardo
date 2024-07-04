import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  final int version = 1;
  final String dbName = 'cats.db';
  final String tableName = 'favorite_cats';

  Database? _db;

  Future<Database> openDB() async {
    _db ??= await openDatabase(join(await getDatabasesPath(), dbName),
        onCreate: (db, version) {
      String query =
          'CREATE TABLE $tableName(id TEXT PRIMARY KEY, name TEXT, origin TEXT, energy_level INTEGER, description TEXT, temperament TEXT, intelligence INTEGER, reference_image_id TEXT)';
      db.execute(query);
    }, version: version);
    return _db as Database;
  }
}
