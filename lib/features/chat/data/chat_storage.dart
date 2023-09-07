import 'package:chatapp_test/core/core.dart';
import 'package:chatapp_test/features/chat/models/message.dart';

@lazySingleton
class ChatStorage {
  Future<Either<Failure, List<Message>>> getChat() {
    return handleExceptions(
      () async {
        // TODO: базу данных
        return [
          const Message(text: 'vasya', isIncoming: true),
          const Message(text: 'petya', isIncoming: false),
          const Message(text: 'vasya', isIncoming: true),
        ];
      },
    );
  }
}
