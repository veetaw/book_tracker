import '../models/search.dart';
import 'database_provider.dart';

class SearchDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> addSearch(Search search) async {
    final db = await dbProvider.database;

    return db.insert(
      search_table,
      {
        'search': search.text,
      },
    );
  }

  Future<List<Search>> getAll([term]) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> rawData;
    if (term == null || term.length < 1)
      rawData = await db.rawQuery(
        "SELECT * FROM $search_table",
      );
    else
      rawData = await db.rawQuery(
        "SELECT * FROM $search_table WHERE search LIKE '$term%'",
      );

    return rawData.isNotEmpty
        ? rawData.map((i) => Search.fromDatabaseJson(i)).toList()
        : [];
  }

  Future<int> deleteSearch(Search search) async {
    final db = await dbProvider.database;
    return await db.delete(
      search_table,
      where: 'id = ?',
      whereArgs: [search.index],
    );
  }
}
