import 'package:drift/drift.dart';
import 'package:drift/web/worker.dart';
import 'package:injectable/injectable.dart';

part 'database.g.dart';

@lazySingleton
@DriftDatabase(
  include: {
    'tables.drift',
  },
)
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_connect());

  @override
  int get schemaVersion => 1;

  Future<List<ChatData>> getMessages() async {
    return await select(chat).get();
  }

  Future<void> saveMessage(ChatCompanion companion) async {
    await into(chat).insert(companion);
  }

  Future<void> clearMessages() async {
    await delete(chat).go();
  }
}

QueryExecutor _connect() {
  return DatabaseConnection.delayed(
    connectToDriftWorker(
      'worker.dart.js',
      mode: DriftWorkerMode.dedicated,
    ),
  );
}
