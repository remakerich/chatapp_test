import 'dart:async';
import 'dart:convert';

import 'package:chatapp_test/core/core.dart';
import 'package:chatapp_test/features/chat/models/message.dart';
import 'dart:js' as js;

@lazySingleton
class ChatRepository {
  Future<Either<Failure, Stream<Message>>> getChatStream() {
    return handleExceptions(
      () async {
        late StreamController<Message> controller;
        Timer? timer;

        const duration = Duration(seconds: 3);

        void getMessage(Timer timer) {
          final message = js.context.callMethod('getRandomMessage');
          final string = js.context['JSON'].callMethod('stringify', [message]);
          final map = json.decode(string);
          final parsed = Message.fromJson(map);
          controller.add(parsed);
        }

        void startTimer() {
          timer = Timer.periodic(duration, getMessage);
        }

        void stopTimer() {
          timer?.cancel();
          timer = null;
        }

        controller = StreamController<Message>(
          onListen: startTimer,
          onPause: stopTimer,
          onResume: startTimer,
          onCancel: stopTimer,
        );

        return controller.stream;
      },
    );
  }
}
