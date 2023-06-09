import '../dbmanager/dbmanager.dart';
import '../model/gpt.dart';

void initData() async {}

Future<int> insert(Map<String, dynamic> data) async {
  final db = await DBManager.instance.database(initFunc: initData);
  Map<String, dynamic> data1 = Map.from(data);
  data1['created_time'] = DateTime.now().millisecondsSinceEpoch.toString();
  data1['modified_time'] = DateTime.now().millisecondsSinceEpoch.toString();
  return await db.insert('gpt', data1);
}

Future<int> delete(int id) async {
  final db = await DBManager.instance.database(initFunc: initData);
  return await db.delete('gpt', where: 'id = ?', whereArgs: [id]);
}

Future<List<GPT>> getList(
    {String? where, int offset = 0, int limit: 20, orderBy: 'desc'}) async {
  final db = await DBManager.instance.database();
  final List<Map<String, dynamic>> maps = await db.query('gpt',
      where: where, offset: offset, limit: limit, orderBy: orderBy);
  return List.generate(maps.length, (i) {
    return GPT.fromMap(maps[i]);
  });
}
