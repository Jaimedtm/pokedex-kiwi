/* import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'MoorDatabase.g.dart';

class Favorite extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get iindex => integer()();
  TextColumn get name => text().withLength(min: 1, max: 30)();
}

@UseMoor(tables: [Favorite])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super((FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          logStatements: true,
        )));

  @override
  int get schemaVersion => 1;

  Future<List<Favorite>> getAllTasks() => select(favorites).get();
  Future insertTask(Favorite favorite) => into(favorites).insert(favorite);
  Future updateTask(Favorite favorite) => update(favorites).replace(favorite);
  Future deleteTask(Favorite favorite) => delete(favorites).delete(favorite);
}
 */
