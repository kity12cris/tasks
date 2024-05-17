import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class TaskDatabase {


  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'todo.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE task(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        createdate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<int> createTask(String? title, String? descrption) async {
    final db = await TaskDatabase.db();

    final data = {'title': title, 'description': descrption};
    final id = await db.insert('task', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;

  }
  // Read all items
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await TaskDatabase.db();
    return db.query('task', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await TaskDatabase.db();
    return db.query('task', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateTask(
      int id, String title, String? descrption) async {
    final db = await TaskDatabase.db();

    final data = {
      'title': title,
      'description': descrption,
      'createdate': DateTime.now().toString()
    };

    final result =
    await db.update('task', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteTask(int id) async {
    final db = await TaskDatabase.db();
    try {
      await db.delete("task", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}