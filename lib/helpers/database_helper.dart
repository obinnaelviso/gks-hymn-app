import 'dart:io';

import 'package:flutter/services.dart';
import 'package:gks_hymn/models/config.dart';
import 'package:gks_hymn/models/hymn.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._internal();
  static final DatabaseHelper instance = DatabaseHelper._internal();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    final String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, "gks_hymn.db");

    // Check if database exists
    final bool exists = await databaseExists(path);
    if (!exists) {
      // Should happen only the first time you launch your application
      // print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {} // Copy from asset

      ByteData data = await rootBundle.load(join("assets", "gks_hymn.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    }
    // else {
    //   // print("Opening existing database");
    // }

    // open the database
    return await openDatabase(path, readOnly: true);
  }

  Future<List<Hymn>> getHymns() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> hymns = await db.query('hymns');
    List<Hymn> hymnList = hymns.isNotEmpty
        ? hymns.map((hymn) => Hymn.fromMap(hymn)).toList()
        : [];
    return hymnList;
  }

  Future<Config> getConfig(String configName) async {
    final Database db = await instance.database;
    final configs = await db.query('configs',
        where: "key =  ?", whereArgs: [configName], limit: 1);
    List<Config> configList = configs.isNotEmpty
        ? configs.map((config) => Config.fromMap(config)).toList()
        : [];
    return configList.first;
  }
}
