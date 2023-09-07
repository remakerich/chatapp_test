import 'dart:async';

import 'package:chatapp_test/features/chat/data/chat_repository.dart';
import 'package:chatapp_test/features/chat/data/chat_storage.dart';
import 'package:chatapp_test/features/chat/models/message.dart';
import 'package:chatapp_test/core/core.dart';

@injectable
class ChatCubit extends Cubit<AsyncState<List<Message>>> {
  ChatCubit(
    this._chatRepository,
    this._chatStorage,
  ) : super(const AsyncLoading()) {
    _started();
  }

  final ChatRepository _chatRepository;
  final ChatStorage _chatStorage;

  List<Message> _messages = [];
  StreamSubscription<Message>? _chatSubscription;

  _started() async {
    final result = await _chatStorage.getChat();

    await result.when(
      left: (failure) async => emit(AsyncError(failure)),
      right: (data) async {
        _messages = data.toList();
        await _subscribeToChat();
      },
    );
  }

  _subscribeToChat() async {
    final result = await _chatRepository.getChatStream();

    result.when(
      left: (failure) => emit(AsyncError(failure)),
      right: (chatStream) {
        _chatSubscription?.cancel();
        _chatSubscription = chatStream.listen(_messageReceived);
        emit(AsyncData(_messages));
      },
    );
  }

  _messageReceived(Message message) async {
    _messages.add(message);
    final reversed = _messages.reversed.toList();
    emit(AsyncData(reversed));
    await _chatStorage.saveMessage(message);
  }

  sendMessage(String text) async {
    final newMessage = Message(
      text: text,
      isIncoming: false,
    );
    _messages.add(newMessage);
    final reversed = _messages.reversed.toList();
    // TODO reversed and emit bug
    await _chatStorage.saveMessage(newMessage);
    emit(AsyncData(reversed));
  }
}
