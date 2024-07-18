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

  Future<Database> _initDatabase() async {
    String databasesPath = await sqFLiteDatabase.getDatabasesPath();
    String drosakDatabaseName = "drosak.db";
    String realDatabasePath = join(databasesPath, drosakDatabaseName);
    int versionDataBase = 6;
    _db ??= await sqFLiteDatabase.openDatabase(
      realDatabasePath,
      onOpen: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: _onCreate,
      onUpgrade: (db, oldVersion, newVersion) async {
        await (db.execute('DROP TABLE IF EXISTS $educationalStageTableName'));
        await db.execute("CREATE TABLE IF NOT EXISTS $educationalStageTableName"
            " ( $educationalStageID INTEGER PRIMARY KEY AUTOINCREMENT ,"
            "  $educationalStageName TEXT , "
            "  $educationalStageDesc TEXT , "
            "  $educationalStageStatus INTEGER DEFAULT 1 , "
            "  $educationalStageCreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP , "
            "  $educationalStageImage  TEXT )");
        print(db);
        print(oldVersion);
        print(newVersion);
      },
      version: versionDataBase,
    );
    return _db!;
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE IF NOT EXISTS $educationalStageTableName"
        " ( $educationalStageID INTEGER PRIMARY KEY AUTOINCREMENT ,"
        "  $educationalStageName TEXT , "
        "  $educationalStageDesc TEXT , "
        "  $educationalStageStatus INTEGER DEFAULT 1 , "
        "  $educationalStageCreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP , "
        "  $educationalStageImage  TEXT )");

    /* await db.execute(
      "CREATE TABLE IF NOT EXISTS $_productTable"
      " ( $_productColumnId INTEGER PRIMARY KEY AUTOINCREMENT,"
      " $_productColumnName TEXT ,"
      " $_productColumnPrice REAL ,"
      " $_productColumnCount INTEGER );",
    );
    await db.execute(
      "CREATE TABLE IF NOT EXISTS $_salesTable"
      " ( $_salesColumnId INTEGER PRIMARY KEY AUTOINCREMENT,"
      " $_salesColumnProductID INTEGER ,"
      " $_salesColumnUserID INTEGER  , "
      " CONSTRAINT user_sales_relation FOREIGN KEY ($_salesColumnProductID) REFERENCES $_productTable ($_productColumnId) ON DELETE CASCADE ON UPDATE CASCADE ,"
      " CONSTRAINT product_sales_relation FOREIGN KEY ($_salesColumnUserID) REFERENCES $_userTable ($_userColumnID) ON DELETE CASCADE ON UPDATE CASCADE "
      " );",
    );*/
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
  Future<List<Map<String, Object?>>> select({
    required String tableName,
  }) async {
    await _initDatabase();
    List<Map<String, Object?>> data = await _db!.query(tableName);
    await _db!.close();
    return data;
  }

  @override
  Future<List<Map<String, Object?>>> search(
      {required String tableName, required String searchWord}) async {
    await _initDatabase();
    List<Map<String, Object?>> data = await _db!.query(
      tableName,
      where: '$educationalStageName LIKE ?',
      whereArgs: ['%$searchWord%'],
    );
    await _db!.close();
    return data;
  }

  @override
  Future<bool> update(
      {required String tableName,
      required Map<String, Object?> values,
      required String where}) async {
    await _initDatabase();
    int deleted = await _db!.update(tableName, values, where: where);
    await _db!.close();
    return deleted > 0 ? true : false;
  }
}

// users // products // sales
