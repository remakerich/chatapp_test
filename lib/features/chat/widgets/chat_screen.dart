import 'package:chatapp_test/features/chat/providers/chat_cubit.dart';
import 'package:chatapp_test/features/chat/models/message.dart';
import 'package:chatapp_test/core/core.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: Center(child: _Chat()),
        ),
        _InputArea(),
      ],
    );
  }
}

class _InputArea extends StatelessWidget {
  const _InputArea();

  @override
  Widget build(BuildContext context) {
    final chatState = context.watch<ChatCubit>().state;

    return chatState.maybeWhen(
      data: (_) => const _InputField(),
      orElse: () => const SizedBox(),
    );
  }
}

class _InputField extends StatefulWidget {
  const _InputField();

  @override
  State<_InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<_InputField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Constants.outerPadding,
        0,
        Constants.outerPadding,
        Constants.outerPadding,
      ),
      child: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          labelText: 'Сообщение',
        ),
        onSubmitted: (value) {
          context.read<ChatCubit>().sendMessage(value);
          _controller.clear();
        },
      ),
    );
  }
}

class _Chat extends StatelessWidget {
  const _Chat();

  @override
  Widget build(BuildContext context) {
    final chatState = context.watch<ChatCubit>().state;

    return chatState.when(
      loading: () => const CircularProgressIndicator(),
      data: (messages) => _MessagesList(messages),
      error: (error) => Text(error.message),
    );
  }
}

class _MessagesList extends StatelessWidget {
  const _MessagesList(this.messages);

  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: messages.length,
      reverse: true,
      padding: const EdgeInsets.all(
        Constants.outerPadding,
      ),
      separatorBuilder: (context, index) => const SizedBox(
        height: Constants.innerPadding,
      ),
      itemBuilder: (context, index) => _MessageTile(
        key: ValueKey(messages[index].hashCode.toString()),
        message: messages[index],
      ),
    );
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          message.isIncoming ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        const Flexible(
          flex: Constants.messageTileEmptySpaceFlex,
          child: SizedBox(),
        ),
        Flexible(
          flex: Constants.messageBubbleFlex,
          child: _MessageBubble(message),
        ),
      ],
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble(this.message);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Constants.innerPadding),
      decoration: BoxDecoration(
        color: message.isIncoming ? Colors.grey[300] : Colors.lightBlue[200],
        borderRadius: BorderRadius.only(
          topLeft: message.isIncoming
              ? Radius.zero
              : const Radius.circular(Constants.borderRadius),
          topRight: const Radius.circular(Constants.borderRadius),
          bottomLeft: const Radius.circular(Constants.borderRadius),
          bottomRight: message.isIncoming
              ? const Radius.circular(Constants.borderRadius)
              : Radius.zero,
        ),
      ),
      child: Text(
        message.text,
      ),
    );
  }
}
