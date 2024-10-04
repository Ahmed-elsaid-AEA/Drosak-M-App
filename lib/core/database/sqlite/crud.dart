abstract class CRUD {
  Future<bool> insert({
    required String tableName,
    required Map<String, Object?> values,
  });

  Future<bool> update(
      {required String tableName,
      List<Object?>? whereArgs,
      required Map<String, Object?> values,
      required String where});

  Future<bool> delete({required String tableName, required String where});

  Future<List<Map<String, Object?>>> select({
    required String tableName,
    String? where,
    List<Object?>? whereArgs,
  });

  Future<List<Map<String, Object?>>> selectUsingQuery({
    required String query,
  });

  Future<List<Map<String, Object?>>> searchUsingLike({
    required String tableName,
    required String searchWord,
    required String columnName,
  });

  Future<List<Map<String, Object?>>> search({
    required String tableName,
    required String searchedId,
    required String columnID,
  });
}
