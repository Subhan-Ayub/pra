import 'dart:async';
import 'package:flutter_task/src/utils/models/task_model.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper extends GetxController {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get databasee async {
    if (database == null) {
      database = await initializeDatabase();
    }
    print('jjj');
    return  database!;
  }

  Future<Database> initializeDatabase() async {
    final dbPath = await getDatabasesPath();
    const dbName = 'prac.db';
    print('creating');
    return await openDatabase(
      '$dbPath/$dbName',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, completed INTEGER)');
      },
    );
  }

Future<int> insertTask(Task task) async {
  final db = await databasee;
  print(task.toMap());
  return await db.insert('tasks', {"title":'sss',"completed":0});
}

Future<List<Task>> getTasks() async {
  final db = await databasee;
  final List<Map<String, dynamic>> maps = await db.query('tasks');
  print(maps);
  return List.generate(maps.length, (i) => Task.fromMap(maps[i]));
}

Future<void> updateTask(Task task) async {
  final db = await databasee;
  await db.update(
    'tasks',
    task.toMap(),
    where: 'id = ?',
    whereArgs: [task.id],
  );
}

Future<void> deleteTask(int id) async {
  final db = await databasee;
  await db.delete(
    'tasks',
    where: 'id = ?',
    whereArgs: [id],
  );
}
}