import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'datacount_model.dart';

class DatabaseInstance {
  final String _dbName = 'data_counter.db';
  final int _dbVer = 1;

  final String table = 'counter';
  final String id = 'id';
  final String serveCount = 'serve_count';
  final String smashCount = 'smash_count';
  final String driveCount = 'drive_count';
  final String createdAt = 'created_at';

  Database? _database;

  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future _initDatabase() async {
    Directory documenDirectory = await getApplicationDocumentsDirectory();
    String path = join(documenDirectory.path, _dbName);
    return openDatabase(path, onCreate: _onCreate, version: _dbVer);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $table ($id INTEGER PRIMARY KEY, $serveCount INTEGER NULL, $smashCount INTEGER NULL, $driveCount INTEGER  NULL, $createdAt TEXT NULL)');
  }

  Future<List<DatacountModel>> getData() async {
    final data = await _database!.query(table);
    List<DatacountModel> result =
        data.map((e) => DatacountModel.fromJson(e)).toList();
    return result;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    final query = await _database!.insert(table, row);
    return query;
  }
}
