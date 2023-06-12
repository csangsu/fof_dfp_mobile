import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

class DbManager {
  static Future<String> _loadSqlFile() async {
    return await rootBundle.loadString('assets/sql/ddl.sql');
  }

  static Future<Database> _getDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    final result = await sql.openDatabase(
      path.join(dbPath, dotenv.env['DB_NAME'] ?? 'sample.db'),
      onCreate: (db, version) async {
        String sqlQuery = await _loadSqlFile();
        if (sqlQuery == '') {
          return;
        }

        List<String> statements = sqlQuery.split(';');
        // 마지막 요소는 빈 문자열이므로 제거합니다.
        statements.removeLast();

        for (String statement in statements) {
          await db.execute(statement);
        }
      },
      version: int.parse(dotenv.env['DB_VERSION'] ?? '1'),
    );
    return result;
  }

  static Future<int> insert(
      String tableName, Map<String, dynamic> param) async {
    final db = await _getDatabase();
    return await db.insert(tableName, param,
        conflictAlgorithm: ConflictAlgorithm.fail);
  }

  static Future<int> update(String tableName, Map<String, dynamic> param,
      {String? where, List<Object>? whereArgs}) async {
    final db = await _getDatabase();
    return await db.update(tableName, param,
        where: where,
        whereArgs: whereArgs,
        conflictAlgorithm: ConflictAlgorithm.fail);
  }

  static Future<int> delete(String tableName,
      {String? where, List<Object>? whereArgs}) async {
    final db = await _getDatabase();
    return await db.delete(tableName, where: where, whereArgs: whereArgs);
  }

  static Future<List<Map<String, Object?>>> select(String tableName,
      {bool? distinct,
      List<String>? columns,
      String? where,
      List<Object?>? whereArgs,
      String? groupBy,
      String? having,
      String? orderBy,
      int? limit,
      int? offset}) async {
    final db = await _getDatabase();
    return db.query(tableName,
        distinct: distinct,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
        offset: offset);
  }
}
