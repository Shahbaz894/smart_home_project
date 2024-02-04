// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// import '../model/temp_model.dart';
//
// class DatabaseHelper {
//   static Database? _database;
//   static const String dbName = 'temp_database.db';
//   static const String tableName = 'temp_table';
//
//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     }
//
//     _database = await initDatabase();
//     return _database!;
//   }
//
//   Future<Database> initDatabase() async {
//     final path = await getDatabasesPath();
//     final databasePath = join(path, dbName);
//
//     return await openDatabase(databasePath, version: 1, onCreate: (db, version) async {
//       await db.execute('''
//         CREATE TABLE $tableName(
//           id INTEGER PRIMARY KEY AUTOINCREMENT,
//           tempValue REAL,
//           timestamp TEXT
//         )
//       ''');
//     });
//   }
//
//   Future<int> insertTemp(TempModel temp) async {
//     final db = await database;
//     return await db.insert(tableName, temp.toMap());
//   }
//
//   Future<int> deleteTemp(int id) async {
//     final db = await database;
//     return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
//   }
//
//   Future<List<TempModel>> getAllTemps() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query(tableName);
//     return List.generate(maps.length, (i) {
//       return TempModel(
//         id: maps[i]['id'],
//         tempValue: maps[i]['tempValue'],
//         timestamp: DateTime.parse(maps[i]['timestamp']),
//       );
//     });
//   }
// }
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/temp_model.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'temp_data.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE temp_data (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            tempValue REAL,
            timestamp INTEGER
          )
        ''');
      },
      version: 1,
    );
  }

  // CRUD operations for temp data
  static Future<void> insertTempData(TempData data) async {
    final db = await database;
    await db.insert('temp_data', data.toMap());
  }

  static Future<List<TempData>> getAllTempData() async {
    final db = await database;
    final result = await db.query('temp_data');
    return result.map((e) => TempData.fromMap(e)).toList();
  }

  static Future<void> deleteTempData(int id) async {
    final db = await database;
    await db.delete('temp_data', where: 'id = ?', whereArgs: [id]);
  }
}
