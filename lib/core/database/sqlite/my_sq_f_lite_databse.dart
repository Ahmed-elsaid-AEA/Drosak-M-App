import 'dart:async';
import 'package:drosak_m_app/core/database/sqlite/crud.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart' as sqFLiteDatabase;
import 'package:path/path.dart';

class MySqFLiteDatabase extends CRUD {

  Database? _db;
  static const String educationalStageTableName = 'educationalStageTableName';
  static const String educationalStageID = 'id';
  static const String educationalStageName = 'name';
  static const String educationalStageDesc = 'desc';
  static const String educationalStageImage = 'image';
  static const String educationalStageCreatedAt = 'created_at';
  static const String educationalStageStatus = 'status';

//!======================= group table =============
  static const String groupTableName = 'groups';
  static const String groupColumnID = 'id';
  static const String groupColumnName = 'name';
  static const String groupColumnNote = 'note';
  static const String groupColumnIDEducation = 'educationID';

//!======================= Appointments table =============
  static const String appointmentsTableName = 'Appointments';
  static const String appointmentsColumnID = 'id';
  static const String appointmentsColumnDay = 'day';
  static const String appointmentsColumnTime = 'time';
  static const String appointmentsColumnMS = 'MS';
  static const String appointmentsColumnIDGroups = 'idGroups';

//!======================= student table =============
  static const String studentsTableName = 'students';
  static const String studentsColumnID = 'id';
  static const String studentsColumnName = 'name';
  static const String studentsColumnNote = 'note';
  static const String studentsColumnImage = 'image';
  static const String studentsColumnIDGroups = 'groups_id';
  static const String studentsColumnCreatedAt = 'created_at';
//!======================= audience table =============
  static const String audienceTableName = 'audience';
  static const String audienceColumnID = 'id';
  static const String audienceColumnStatus = 'status';
  static const String audienceColumnIDStudent = 'student_id';
  static const String audienceColumnDetail = 'detail';
  static const String audienceColumnCreatedAt = 'created_at';

  Future<Database> _initDatabase() async {
    String databasesPath = await sqFLiteDatabase.getDatabasesPath();
    String drosakDatabaseName = "drosak.db";
    String realDatabasePath = join(databasesPath, drosakDatabaseName);
    int versionDataBase = 4;
    _db ??= await sqFLiteDatabase.openDatabase(
      realDatabasePath,
      onOpen: _onOpen,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      version: versionDataBase,
    );
    return _db!;
  }

  FutureOr<void> _onOpen(db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    }

  FutureOr<void> _onUpgrade(db, oldVersion, newVersion) async {
      await (db.execute('DROP TABLE IF EXISTS $educationalStageTableName'));
      await (db.execute('DROP TABLE IF EXISTS $groupTableName'));
      await (db.execute('DROP TABLE IF EXISTS $studentsTableName'));
      await (db.execute('DROP TABLE IF EXISTS $appointmentsTableName'));
      await (db.execute('DROP TABLE IF EXISTS $audienceTableName'));
      await db.execute("CREATE TABLE IF NOT EXISTS $educationalStageTableName"
          " ( $educationalStageID INTEGER PRIMARY KEY AUTOINCREMENT ,"
          "  $educationalStageName TEXT , "
          "  $educationalStageDesc TEXT , "
          "  $educationalStageStatus INTEGER DEFAULT 1 , "
          "  $educationalStageCreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP , "
          "  $educationalStageImage  TEXT )");
      await db.execute("CREATE TABLE IF NOT EXISTS $groupTableName"
          " ( $groupColumnID INTEGER PRIMARY KEY AUTOINCREMENT ,"
          "  $groupColumnName TEXT , "
          "  $groupColumnNote TEXT , "
          "  $groupColumnIDEducation  INTEGER, "
          "  CONSTRAINT group_and_education_stage FOREIGN KEY ($groupColumnIDEducation) REFERENCES $educationalStageTableName($educationalStageID) ON DELETE CASCADE ON UPDATE CASCADE"
          ")");
      await db.execute("CREATE TABLE IF NOT EXISTS  $appointmentsTableName"
          " ( $appointmentsColumnID INTEGER PRIMARY KEY AUTOINCREMENT ,"
          "  $appointmentsColumnDay TEXT , "
          "  $appointmentsColumnTime TEXT , "
          "  $appointmentsColumnMS TEXT, "
          "  $appointmentsColumnIDGroups  INTEGER ,"
          "  CONSTRAINT group_and_appointment FOREIGN KEY ($appointmentsColumnIDGroups) REFERENCES $groupTableName($groupColumnID) ON DELETE CASCADE ON UPDATE CASCADE"
          ")");
      //?======================== create student table =========
      await db.execute("CREATE TABLE IF NOT EXISTS  $studentsTableName"
          " ( $studentsColumnID INTEGER PRIMARY KEY AUTOINCREMENT ,"
          "  $studentsColumnName TEXT , "
          "  $studentsColumnImage TEXT , "
          "  $studentsColumnNote TEXT, "
          "  $educationalStageCreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP , "
          "  $studentsColumnIDGroups  INTEGER ,"
          "  CONSTRAINT group_and_students FOREIGN KEY ($studentsColumnIDGroups) REFERENCES $groupTableName($groupColumnID) ON DELETE CASCADE ON UPDATE CASCADE"
          ")");
      //?======================== create audience table =========
      await db.execute("CREATE TABLE IF NOT EXISTS  $audienceTableName"
          " ( $audienceColumnID INTEGER PRIMARY KEY AUTOINCREMENT ,"
          "  $audienceColumnStatus TEXT , "
          "  $audienceColumnIDStudent INT , "
          "  $audienceColumnDetail TEXT, "
          "  $audienceColumnCreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP , "
          "  CONSTRAINT student_and_audience FOREIGN KEY ($audienceColumnIDStudent) REFERENCES $studentsTableName($studentsColumnID) ON DELETE CASCADE ON UPDATE CASCADE"
          ")");
    }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE IF NOT EXISTS $educationalStageTableName"
        " ( $educationalStageID INTEGER PRIMARY KEY AUTOINCREMENT ,"
        "  $educationalStageName TEXT , "
        "  $educationalStageDesc TEXT , "
        "  $educationalStageStatus INTEGER DEFAULT 1 , "
        "  $educationalStageCreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP , "
        "  $educationalStageImage  TEXT )");
    await db.execute("CREATE TABLE IF NOT EXISTS $groupTableName"
        " ( $groupColumnID INTEGER PRIMARY KEY AUTOINCREMENT ,"
        "  $groupColumnName TEXT , "
        "  $groupColumnNote TEXT , "
        "  $groupColumnIDEducation  INTEGER, "
        "  CONSTRAINT group_and_education_stage FOREIGN KEY ($groupColumnIDEducation) REFERENCES $educationalStageTableName($educationalStageID) ON DELETE CASCADE ON UPDATE CASCADE"
        ")");
    await db.execute("CREATE TABLE IF NOT EXISTS  $appointmentsTableName"
        " ( $appointmentsColumnID INTEGER PRIMARY KEY AUTOINCREMENT ,"
        "  $appointmentsColumnDay TEXT , "
        "  $appointmentsColumnTime TEXT , "
        "  $appointmentsColumnMS TEXT, "
        "  $appointmentsColumnIDGroups  INTEGER ,"
        "  CONSTRAINT group_and_appointment FOREIGN KEY ($appointmentsColumnIDGroups) REFERENCES $groupTableName($groupColumnID) ON DELETE CASCADE ON UPDATE CASCADE"
        ")");
    //?======================== create student table =========
    await db.execute("CREATE TABLE IF NOT EXISTS  $studentsTableName"
        " ( $studentsColumnID INTEGER PRIMARY KEY AUTOINCREMENT ,"
        "  $studentsColumnName TEXT , "
        "  $studentsColumnImage TEXT , "
        "  $studentsColumnNote TEXT, "
        "  $educationalStageCreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP , "
        "  $studentsColumnIDGroups  INTEGER ,"
        "  CONSTRAINT group_and_students FOREIGN KEY ($studentsColumnIDGroups) REFERENCES $groupTableName($groupColumnID) ON DELETE CASCADE ON UPDATE CASCADE"
        ")");
    //?======================== create audience table =========
    await db.execute("CREATE TABLE IF NOT EXISTS  $audienceTableName"
        " ( $audienceColumnID INTEGER PRIMARY KEY AUTOINCREMENT ,"
        "  $audienceColumnStatus TEXT , "
        "  $audienceColumnIDStudent INT , "
        "  $audienceColumnDetail TEXT, "
        "  $audienceColumnCreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP , "
        "  CONSTRAINT student_and_audience FOREIGN KEY ($audienceColumnIDStudent) REFERENCES $studentsTableName($studentsColumnID) ON DELETE CASCADE ON UPDATE CASCADE"
        ")");
  }

  @override
  Future<bool> delete(
      {required String tableName, required String where}) async {
    await _initDatabase();
    int deleted = await _db!.delete(
      tableName,
      where: where,
    );
    await _db!.close();
    return deleted > 0 ? true : false;
  }

  @override
  Future<bool> insert(
      {required String tableName, required Map<String, Object?> values}) async {
    // TODO: implement insert
    await _initDatabase();
    int inserted = await _db!.insert(tableName, values);
    await _db!.close();
    return inserted > 0 ? true : false;
  }

  @override
  Future<int> insertReturnedId(
      {required String tableName, required Map<String, Object?> values}) async {
    // TODO: implement insert
    await _initDatabase();
    int inserted = await _db!.insert(tableName, values);
    await _db!.close();
    return inserted;
  }

  @override
  Future<List<Map<String, Object?>>> select({
    required String tableName,
    String? where,
    List<Object?>? whereArgs,
  }) async {
    await _initDatabase();
    List<Map<String, Object?>> data =
        await _db!.query(tableName, where: where, whereArgs: whereArgs);
    await _db!.close();
    return data;
  }

  @override
  Future<List<Map<String, Object?>>> selectUsingQuery({
    required String query,
  }) async {
    await _initDatabase();
    List<Map<String, Object?>> data = await _db!.rawQuery(query);
    await _db!.close();
    return data;
  }

  @override
  Future<List<Map<String, Object?>>> searchUsingLike({
    required String tableName,
    required String searchWord,
    required String columnName,
  }) async {
    await _initDatabase();
    List<Map<String, Object?>> data = await _db!.query(
      tableName,
      where: '$columnName LIKE ?',
      whereArgs: ['%$searchWord%'],
    );
    await _db!.close();
    return data;
  }

  @override
  Future<List<Map<String, Object?>>> search({
    required String tableName,
    required String searchedId,
    required String columnID,
  }) async {
    await _initDatabase();
    List<Map<String, Object?>> data = await _db!.query(
      tableName,
      where: '$columnID == ?',
      whereArgs: [searchedId],
    );
    await _db!.close();
    return data;
  }

  @override
  Future<bool> update(
      {required String tableName,
      required Map<String, Object?> values,
      List<Object?>? whereArgs,
      required String where}) async {
    await _initDatabase();
    int deleted = await _db!
        .update(tableName, values, where: where, whereArgs: whereArgs);
    await _db!.close();
    return deleted > 0 ? true : false;
  }
}

// users // products // sales
