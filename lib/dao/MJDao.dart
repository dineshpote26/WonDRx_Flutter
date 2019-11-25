import 'package:wondrx_assignment/database/database.dart';
import 'package:wondrx_assignment/model/Song.dart';

class MJDao{

  final dbProvider = DatabaseProvider.dbProvider;

  //add song
  Future<int> createMJSongList(Song songs) async{
    final db = await dbProvider.database;
    var result = db.insert(dbProvider.testTABLE, songs.toJson());
    return result;
  }

  //get all song
  Future<List<Song>> getLocalMJSongLis(
      {List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(dbProvider.testTABLE,
            columns: columns, where: 'trackName LIKE ?', whereArgs: ["%$query%"]);
    } else {
      result = await db.query(dbProvider.testTABLE, columns: columns);
    }

    List<Song> patients = result.isNotEmpty
        ? result.map((item) => Song.fromJson(item)).toList()
        : [];
    return patients;
  }

  //Delete song
  Future<int> deleteTodo(int id) async {
    final db = await dbProvider.database;
    var result =
    await db.delete(dbProvider.testTABLE, where: 'id = ?', whereArgs: [id]);
    return result;
  }

}