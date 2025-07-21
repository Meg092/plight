import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import './entity.dart';

class DB extends GetxService {
  Database? _database;

  Future<DB> init() async {
    await dbBase;
    return this;
  }

  Future<Database> get dbBase async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'freq_spark.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE plans (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            rate INTEGER NOT NULL,
            date TEXT
          );
        ''');
      },
    );
  }

  Future<int> insertPlan(Plan plan) async {
    final db = await dbBase;
    return await db.insert('plans', plan.toMap());
  }

  Future<List<Plan>> getAllPlans() async {
    final db = await dbBase;
    final List<Map<String, dynamic>> maps = await db.query(
      'plans',
      orderBy: 'id DESC',
    );
    return maps.map((map) => Plan.fromMap(map)).toList();
  }

  Future<Plan?> getPlanById(int id) async {
    final db = await dbBase;
    final List<Map<String, dynamic>> maps = await db.query(
      'plans',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Plan.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updatePlan(Plan plan) async {
    final db = await dbBase;
    return await db.update(
      'plans',
      plan.toMap(),
      where: 'id = ?',
      whereArgs: [plan.id],
    );
  }

  Future<int> deletePlan(int id) async {
    final db = await dbBase;
    return await db.delete('plans', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearRecords() async {
    final db = await dbBase;
    try {
      await db.delete('plans');
    } catch (e) {
      print('Error clearing table data: $e');
    }
  }

  @override
  void onClose() {
    _database?.close();
    super.onClose();
  }
}
