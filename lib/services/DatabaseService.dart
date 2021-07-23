import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseService {
  DatabaseService._();
  static final DatabaseService db = DatabaseService._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  //didnt defined on create since db already will be created in service start
  //see java code
  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), 'locationData'),
        onCreate: (db, version) {
      print("-------------->DATABASE DID NOT EXISTED");
    }, version: 1);
  }

  Future<dynamic> getReportDataFromLocal() async {
    final db = await database;
    List<Map<String, Object>> res = await db.rawQuery('''
      SELECT * FROM fireStoreLocal
      WHERE DATE(time_start) = DATE('now','localtime')
      

    ''');

    return res;
  }

  Future<List<Map<String, Object>>> getLocationDataFromLocalDB(
      DateTime start, DateTime end) async {
    final db = await database;
    print(start.toIso8601String());
    print(end.toIso8601String().split('T')[0]);
    List<Map<String, Object>> res = await db.rawQuery('''
      SELECT * FROM fireStoreLocal 
      WHERE time_start >='${start.toIso8601String().split('T')[0]}'
      AND time_end <'${end.toIso8601String().split('T')[0]}'
    ''');

    return res;
  }

  Future<dynamic> getallData(DateTime date) async {
    final db = await database;
    List<Map<String, Object>> res = await db.rawQuery('''
      SELECT * FROM fireStoreLocal
    ''');
    return res;
  }
}
