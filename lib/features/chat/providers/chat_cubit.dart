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

  StreamSubscription<Message>? _chatSubscription;

  final _cache = <Message>[];

  List<Message> get _messages => _cache.reversed.toList();
  set _messages(List<Message> newMessages) => _cache.addAll(newMessages);
  _addMessage(Message message) => _cache.add(message);

  _started() async {
    final result = await _chatStorage.getChat();

    await result.when(
      left: (failure) async => emit(AsyncError(failure)),
      right: (data) async {
        _messages = data;
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
    _addMessage(message);
    await _chatStorage.saveMessage(message);
    emit(AsyncData(_messages));
  }

  sendMessage(String text) async {
    final newMessage = Message(
      text: text,
      isIncoming: false,
    );
    _messageReceived(newMessage);
  }
}
