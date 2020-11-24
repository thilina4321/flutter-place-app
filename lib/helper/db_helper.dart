import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> database() async {
    final databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    final db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Test(id INTEGER PRIMARY KEY, title TEXT, image TEXT)');
    });
    return db;
  }

  static Future<void> insert(Map<String, Object> data) async {
    final database = await DBHelper.database();
    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO Test(title, image) VALUES("${data['title']}", "${data['image']}")');
    });
  }

  static Future<List<Map>> get() async {
    final database = await DBHelper.database();
    final data = await database.rawQuery('SELECT * FROM Test');
    return data;
  }

  static Future<void> delete(id) async {
    int dataId = int.parse(id);
    final database = await DBHelper.database();
    final deletedb =
        await database.rawDelete('DELETE FROM Test WHERE id = $dataId');

    return deletedb;
  }
}
