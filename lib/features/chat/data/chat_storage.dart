import 'package:chatapp_test/core/core.dart';
import 'package:chatapp_test/features/chat/models/message.dart';
import 'package:drift/drift.dart';

@lazySingleton
class ChatStorage {
  ChatStorage(
    this._myDatabase,
  );

  final MyDatabase _myDatabase;

  Future<Either<Failure, List<Message>>> getChat() {
    return handleExceptions(
      () async {
        final messages = await _myDatabase.getMessages();

        return messages.map(
          (e) {
            return Message(
              text: e.value ?? '',
              isIncoming: e.isIncoming ?? false,
            );
          },
        ).toList();
      },
    );
  }

  Future<Either<Failure, void>> saveMessage(Message message) {
    return handleExceptions(
      () async {
        final companion = ChatCompanion(
          value: Value(message.text),
          isIncoming: Value(message.isIncoming),
        );

        await _myDatabase.saveMessage(companion);
      },
    );
  }
}
