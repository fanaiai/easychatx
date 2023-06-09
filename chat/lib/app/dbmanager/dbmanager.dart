import 'dart:async';
import '../../app/model/gpt.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  static final DBManager instance = DBManager._init();
  static Database? _database;

  var _createIns = '';
  var _initFunc;

  DBManager._init();

  Future<Database> database({Function? initFunc}) async {
    // _createIns = createIns;
    _initFunc = initFunc;
    if (_database != null) {
      // await _database?.execute(_createIns);
      return _database!;
    }
    _database = await _initDB('beijiuwanle.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    var res = await openDatabase(path, version: 1, onCreate: _createDB);
    if (_initFunc != null) {
      _initFunc();
    }
    return res;
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE gpt (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        role TEXT,
        content TEXT,
        created_time INTEGER,
        modified_time INTEGER
      )
    ''');
  }
}
