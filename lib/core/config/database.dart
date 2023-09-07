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

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        if (details.wasCreated) {
          _addInitialMessages();
        }
      },
    );
  }

  Future<List<ChatData>> getMessages() async {
    return await select(chat).get();
  }

  Future<void> saveMessage(ChatCompanion companion) async {
    await into(chat).insert(companion);
  }

  Future<void> clearMessages() async {
    await delete(chat).go();
  }

  _addInitialMessages() async {
    const initialMessages = [
      ChatCompanion(
        value: Value('initial message 1'),
        isIncoming: Value(true),
      ),
      ChatCompanion(
        value: Value('initial message 2'),
        isIncoming: Value(false),
      ),
    ];

    final inserts = initialMessages.map((e) => into(chat).insert(e));
    await Future.wait(inserts);
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
